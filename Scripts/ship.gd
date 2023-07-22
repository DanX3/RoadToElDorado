extends CharacterBody2D
class_name Ship

@export var max_speed: float
@export var linear_acceleration: float
@export var angular_acceleration: float

var target_direction: Vector2 = Vector2.RIGHT
var target_speed: float = 0

var docked: bool = false
var player_in_boarding_area: Node2D = null


func _ready():
	$PlayerBoardingArea.body_entered.connect(on_body_entered)
	$PlayerBoardingArea.body_exited.connect(on_body_exited)

	rotation = get_orientation(velocity)


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("action") && player_in_boarding_area:
		get_viewport().set_input_as_handled()
		player_in_boarding_area.queue_free()
		undock()


func _physics_process(delta: float):
	if docked:
		return

	var movement = get_movement_direction()
	if movement.length_squared() > 0:
		target_direction = movement.normalized()
		target_speed = max_speed
	else:
		target_speed = 0

	velocity = accelerate(delta)
	move_and_slide()

	if velocity.length_squared() > 0:
		rotation = get_orientation(velocity)


func get_movement_direction() -> Vector2:
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	return Vector2(x, y)


func accelerate(delta: float) -> Vector2:
	var speed = lerp(velocity.length(), target_speed, 1.0 - exp(-linear_acceleration * delta))
	var orientation = lerp_angle(velocity.angle(), target_direction.angle(), 1.0 - exp(-angular_acceleration * delta))

	return Vector2.from_angle(orientation) * speed


func get_orientation(direction: Vector2) -> float:
	return direction.angle() - PI / 2.0


func dock():
	docked = true
	$Camera2D.enabled = false


func undock():
	docked = false
	$Camera2D.enabled = true
	player_in_boarding_area = null


func on_body_entered(body: Node2D):
	player_in_boarding_area = body


func on_body_exited(_body: Node2D):
	player_in_boarding_area = null
