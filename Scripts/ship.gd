extends CharacterBody2D
class_name Ship

@export var max_speed: float
@export var linear_acceleration: float
@export var angular_acceleration: float

var target_direction: Vector2 = Vector2.RIGHT
var target_speed: float = 0

var docked: bool = false


func _ready():
	$InteractableComponent.interacted.connect(on_interacted)
	
	rotation = get_orientation(velocity)


func _physics_process(delta: float):
	if docked:
		return

	var movement = get_movement_direction()
	if movement.length_squared() > 0:
		target_direction = movement.normalized()
		target_speed = max_speed
		if PlayerInventory.contains("manual"):
			target_speed = 1.5 * max_speed
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
	target_speed = 0
	velocity = Vector2.ZERO
	$Camera2D.enabled = false


func undock():
	docked = false
	$Camera2D.enabled = true


func on_interacted():
	Callable(get_tree().get_first_node_in_group("player"), "queue_free").call_deferred()
	undock()
