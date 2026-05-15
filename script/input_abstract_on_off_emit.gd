class_name InputAbstractOnOffEmit
extends Node


signal on_down()
signal on_up()
signal on_change_state(is_down:bool)

@export var current_state:bool


func get_current_state() -> bool:
	return current_state

func is_on() -> bool:
	return current_state

func is_off() -> bool:
	return not current_state

func notify_as_down():
	notify_as_changed_state(true)
	
func notify_as_up():
	notify_as_changed_state(false)
	
func notify_as_changed_state(is_on:bool):
	var changed :bool = is_on != current_state
	current_state=is_on
	if changed:
		if is_on:
			on_down.emit()
		if not is_on:
			on_up.emit()
	on_change_state.emit(current_state)	
