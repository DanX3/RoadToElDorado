extends RigidBody2D

var can_hook = false
var hung_on_end := true

func set_hook(new_can_hook):
	can_hook = new_can_hook

func set_hung_on_end(hung):
	hung_on_end = hung

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
