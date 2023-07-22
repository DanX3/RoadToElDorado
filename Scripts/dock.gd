extends Area2D

var player_scene = preload("res://Scenes/character.tscn")


func _ready():
	body_entered.connect(on_body_entered)


func spawn_player():
	var player = player_scene.instantiate() as Node2D
	get_tree().root.add_child(player)

	player.global_position = $PlayerSpawn.global_position


func on_body_entered(body: Node2D):
	var ship = body as Ship
	if not ship:
		return

	ship.dock()

	Callable(spawn_player).call_deferred()
