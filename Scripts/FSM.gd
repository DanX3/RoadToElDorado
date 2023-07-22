extends Node

class_name FSM

var state = null

signal state_changed(old_state, new_state)

func set_state(new_state):
	if new_state == state:
		return
		
	emit_signal("state_changed", state, new_state)
	
	state = new_state
