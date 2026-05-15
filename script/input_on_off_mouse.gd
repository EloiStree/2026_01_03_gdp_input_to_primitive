class_name InputOnOffMouse
extends InputAbstractOnOffEmit

enum MouseEventToListen {
	MouseLeft = MOUSE_BUTTON_LEFT,
	MouseMiddle = MOUSE_BUTTON_MIDDLE,
	MouseRight = MOUSE_BUTTON_RIGHT,
	ScrollLeft = MOUSE_BUTTON_WHEEL_LEFT,
	ScrollUp = MOUSE_BUTTON_WHEEL_UP,
	ScrollRight = MOUSE_BUTTON_WHEEL_RIGHT,
	ScrollDown = MOUSE_BUTTON_WHEEL_DOWN,
}

@export var mouse_event_to_listen: MouseEventToListen
@export var use_print_debug: bool = true

func _input(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return
	
	if event.button_index == mouse_event_to_listen:
		var is_pressed = event.pressed	
		if use_print_debug:
			print("Mouse event: ", mouse_event_to_listen, " is_pressed: ", is_pressed, " On: ", is_on() )
		notify_as_changed_state(is_pressed)
