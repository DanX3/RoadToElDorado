extends Node2D
class_name Door

@onready var animation_player = $CanvasLayer/TransitionRect/AnimationPlayer

var player: Player

func _on_in_body_entered(body):
	player = body
	animation_player.play("teleport_to_out")

func _on_out_body_entered(body):
	player = body
	animation_player.play("teleport_to_in")

func teleport_to_in():
	player.global_position += Vector2(0,1)
	player.global_position = $In/PlayerSpawn.global_position

func teleport_to_out():
	player.global_position += Vector2(0,1)
	player.global_position = $Out/PlayerSpawn.global_position
	
