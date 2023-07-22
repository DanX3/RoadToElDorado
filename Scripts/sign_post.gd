extends Area2D
class_name SignPost

@export_multiline var message: String

var message_box_scene = preload("res://Scenes/message_box.tscn")

var player_in_range: bool = false


func _ready():
	body_entered.connect(func(_body: Node2D): player_in_range = true)
	body_exited.connect(func(_body: Node2D): player_in_range = false)


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("action") && player_in_range:
		get_viewport().set_input_as_handled()
		show_message()


func show_message():
	var message_box = message_box_scene.instantiate() as MessageBox
	add_child(message_box)
	
	message_box.display(message)
