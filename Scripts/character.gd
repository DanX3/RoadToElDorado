extends RigidBody2D
class_name Player

@export var SPEED = 3000
@onready var fsm: FSM = $FSM
@onready var pivot = $Pivot

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	var movement = Vector2(Input.get_axis("move_left", "move_right"), \
		Input.get_axis("move_up", "move_down")).normalized()
	apply_central_force(SPEED * movement)
	
	# flip character
	if movement.x != 0.0:
		pivot.scale.x = 1.0 if movement.x >= 0.0 else -1.0
		
	# set correct state
	if movement.length_squared() == 0.0:
		fsm.set_state(AnimState.IDLE)
	else:
		fsm.set_state(AnimState.RUNNING)
	
	if Input.is_action_pressed("rope"):
		hook_force = hook_rotate_force * Vector2.ZERO.direction_to(hook.position).rotated(-0.5 * PI)
		hook.apply_central_force(delta * hook_force)
		queue_redraw()

var hook_force = Vector2.ZERO

func _draw():
	draw_line(hook.position, hook.position + 100.0 * Vector2.ZERO.direction_to(hook.position).rotated(-0.5 * PI), Color.RED, 10.0)

func _input(event):
	if Input.is_action_just_pressed("rope"):
		fsm.set_state(AnimState.ROPE_LAUNCH)
	
	if Input.is_action_just_released("rope"):
		fsm.set_state(AnimState.ROPE_PULL)
	

enum AnimState {
	IDLE,
	RUNNING,
	ROPE_LAUNCH,
	ROPE_PULL,
}

@onready var player = $Pivot/AnimationPlayer
@onready var hook = $Rope/Hook
@export var hook_rotate_force = 20000

func _on_fsm_state_changed(old_state, new_state):
	match new_state:
		AnimState.IDLE:
			player.play("idle")
		AnimState.RUNNING:
			player.play("run")
		AnimState.ROPE_LAUNCH:
			$Rope.show()
			
		AnimState.ROPE_PULL:
			$Rope.hide()
			hook.add_constant_central_force(Vector2.ZERO)
