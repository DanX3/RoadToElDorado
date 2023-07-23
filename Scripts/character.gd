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
	$Label.text = str(fsm.state) + "\nis hanging:" + str(is_hanging)
	if fsm.state == AnimState.ROPE_PULL:
		hook.global_position = hook_position

func _physics_process(delta):
	if not $Rope.visible and not is_hanging:
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
	
	if Input.is_action_pressed("rope") and has_rope():
		hook_force = hook_rotate_force * Vector2.ZERO.direction_to(hook.position).rotated(-0.5 * PI)
		hook.apply_central_force(delta * hook_force)

var hook_force = Vector2.ZERO

func has_rope():
	return PlayerInventory.contains("rope")

func _input(event):
	if Input.is_action_just_pressed("rope") and has_rope():
		hook.freeze = false
		fsm.set_state(AnimState.ROPE_LAUNCH)
	
	if Input.is_action_just_released("rope") and has_rope():
		if hook.can_hook:
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
			if is_hanging:
				fsm.set_state(AnimState.HUNG)
			else:
				fsm.set_state(AnimState.IDLE)

func _on_end_swing():
	if hook.hung_on_end:
		fsm.set_state(AnimState.HUNG)
	else:
		fsm.set_state(AnimState.IDLE)

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

var is_hanging = false

func _on_fsm_state_changed(old_state, new_state):
	match (old_state):
		AnimState.HUNG:
			$CollisionShape2D.disabled = false
	
	match new_state:
		AnimState.IDLE:
			is_hanging = false
			player.play("idle")
			$Rope.hide()
		AnimState.RUNNING:
			player.play("run")
		AnimState.ROPE_LAUNCH:
			$Rope.show()
			$Rope/Hook/CollisionShape2D.disabled = false
		AnimState.ROPE_PULL:
			$Rope/Hook/CollisionShape2D.disabled = true
		AnimState.HUNG:
			is_hanging = true
			$Rope.hide()
			$CollisionShape2D.disabled = true
			player.play("hung")
			print("HUNG state")
