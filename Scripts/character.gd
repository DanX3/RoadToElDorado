extends RigidBody2D
class_name Player

@export var SPEED = 3000
@onready var fsm: FSM = $FSM
@onready var pivot = $Pivot
var hook_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fsm.state == AnimState.ROPE_PULL:
		hook.global_position = hook_position

func _physics_process(delta):
	
	if not $Rope.visible and fsm.state != AnimState.HUNG:
		var movement = Vector2(Input.get_axis("move_left", "move_right"), \
			Input.get_axis("move_up", "move_down")).normalized()
		apply_central_force(SPEED * movement)
	
		# flip character
		if movement.x != 0.0:
			pivot.scale.x = 1.0 if movement.x >= 0.0 else -1.0
			
		if movement.length_squared() == 0.0:
			fsm.set_state(AnimState.IDLE)
		else:
			fsm.set_state(AnimState.RUNNING)
	
	if Input.is_action_pressed("rope"):
		hook_force = hook_rotate_force * Vector2.ZERO.direction_to(hook.position).rotated(-0.5 * PI)
		hook.apply_central_force(delta * hook_force)
		queue_redraw()

var hook_force = Vector2.ZERO

func _input(event):
	if Input.is_action_just_pressed("rope"):
		hook.freeze = false
		fsm.set_state(AnimState.ROPE_LAUNCH)
	
	if Input.is_action_just_released("rope"):
		if hook.can_hook:
			$CollisionShape2D.disabled = true
			fsm.set_state(AnimState.ROPE_PULL)
			var tween = create_tween()
			tween.tween_property(self, "global_position", $Rope/Hook/HookPoint.global_position, 0.5)
			tween.set_ease(Tween.EASE_IN_OUT)
			tween.set_trans(Tween.TRANS_CUBIC)
			tween.play()
			hook.freeze = true
			player.play("swing_to_hook")
			hook_position = hook.global_position
		else:
			$Rope.hide()
			fsm.set_state(AnimState.HUNG)

func _on_end_swing():
	fsm.set_state(AnimState.HUNG)

enum AnimState {
	IDLE,
	RUNNING,
	ROPE_LAUNCH,
	ROPE_PULL,
	HUNG,
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
			pass
		AnimState.HUNG:
			player.play("hung")
			print("HUNG state")
