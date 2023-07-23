extends Node2D


@export var start_messagebox : MessageBox

# Called when the node enters the scene tree for the first time.
func _ready():
	start_messagebox.present()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
