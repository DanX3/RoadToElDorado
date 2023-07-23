extends Node2D


@export var start_messagebox : MessageBox

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

@export var fog: ColorRect

func _on_fog_area_body_entered(body):
	if body is Player or body is Ship:
		fog.show()


func _on_fog_area_body_exited(body):
	if body is Player or body is Ship:
		fog.hide()


func _on_timer_timeout():
	start_messagebox.present()
