extends RigidBody2D


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
		


func _input(event):
	if Input.is_action_just_pressed("rope"):
		print("rope launch")
		fsm.set_state(AnimState.ROPE_LAUNCH)
	
	if Input.is_action_just_released("rope"):
		print("rope pull")
		fsm.set_state(AnimState.ROPE_PULL)


func get_inventory() -> InventoryComponent:
	return $InventoryComponent


enum AnimState {
	IDLE,
	RUNNING,
	ROPE_LAUNCH,
	ROPE_PULL,
}

@onready var player = $Pivot/AnimationPlayer
@onready var hook = $Rope/Hook
@export var hook_rotate_force = 2000

func _on_fsm_state_changed(old_state, new_state):
	print(new_state)
	match new_state:
		AnimState.IDLE:
			player.play("idle")
		AnimState.RUNNING:
			player.play("run")
		AnimState.ROPE_LAUNCH:
			$Rope.show()
			var hook_force = hook_rotate_force * hook.position.normalized().rotated(-0.5 * PI)
			hook.add_constant_central_force(hook_force)
		AnimState.ROPE_PULL:
			$Rope.hide()
			hook.add_constant_central_force(Vector2.ZERO)
