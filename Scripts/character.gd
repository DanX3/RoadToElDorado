extends RigidBody2D


@export var SPEED = 3000

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
