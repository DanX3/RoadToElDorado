extends Area2D
class_name InteractableComponent

signal interacted

var player_in_range: bool = false


func _ready():
	body_entered.connect(func(_body: Node2D): player_in_range = true)
	body_exited.connect(func(_body: Node2D): player_in_range = false)


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("action") && player_in_range:
		get_viewport().set_input_as_handled()
		interacted.emit()
