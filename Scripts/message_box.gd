extends CanvasLayer
class_name MessageBox

@export_multiline var messages: Array[String] = []

var current_message: int = 0


func _input(event: InputEvent):
	if event.is_action_pressed("action"):
		get_viewport().set_input_as_handled()
		
		if !advance():
			get_tree().paused = false
			Callable(queue_free).call_deferred()


func present():
	if messages.is_empty():
		return

	get_tree().paused = true
	advance()


func advance() -> bool:
	if current_message >= messages.size():
		return false

	%MessageBoxContents.text = messages[current_message]
	current_message += 1

	return true
