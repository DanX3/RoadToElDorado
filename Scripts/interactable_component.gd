extends Area2D
class_name InteractableComponent

signal interacted

@onready var interact_icon = %InteractIcon
@onready var animation_player = $CanvasLayer/InteractIcon/AnimationPlayer

var player_in_range: bool = false


func _ready():
	body_entered.connect(on_body_entered)
	body_exited.connect(on_body_exited)


func _process(_delta: float):
	var screen_coord = get_viewport_transform() * owner.global_position
	interact_icon.global_position = screen_coord - interact_icon.pivot_offset


func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("action") && player_in_range:
		get_viewport().set_input_as_handled()
		interacted.emit()


func on_body_entered(_body: Node2D):
	player_in_range = true
	animation_player.play("default")


func on_body_exited(_body: Node2D):
	player_in_range = false
	animation_player.play("RESET")
