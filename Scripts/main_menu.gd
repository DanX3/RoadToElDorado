extends CanvasLayer


func _ready():
	%PlayButton.pressed.connect(on_play_pressed)


func on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
