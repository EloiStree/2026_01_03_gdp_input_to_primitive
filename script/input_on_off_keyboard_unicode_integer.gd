class_name InputOnOffKeyboardUnicodeInteger
extends InputAbstractOnOffEmit


@export var unicode_to_listen: int= 32
@export var use_print_debug: bool = true
@export var last_input_found: int =0

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.is_echo():
			return
		var key_event := event as InputEventKey
		var unicode:int= key_event.unicode
		if unicode==0:
			return
		var unicode_char := char(key_event.unicode)
		if use_print_debug:
			print(key_event.unicode)
		if unicode == unicode_to_listen:
			notify_as_changed_state(key_event.pressed)
