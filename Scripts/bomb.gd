extends Node2D
class_name Bomb

const BLAST_RADIUS: float = 100


func _ready():
	$Timer.timeout.connect(on_timeout)


func on_timeout():
	for blastable in get_tree().get_nodes_in_group("blastable"):
		if global_position.distance_to((blastable as Node2D).global_position) <= BLAST_RADIUS:
			blastable.queue_free.call_deferred()

	$BombSprite.visible = false
	%AnimatedSprite2D.visible = true
	%AnimatedSprite2D.play("default")
	await %AnimatedSprite2D.animation_finished

	queue_free.call_deferred()
