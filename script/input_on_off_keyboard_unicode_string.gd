class_name InputOnOffKeyboardUnicodeString
extends InputAbstractOnOffEmit

@export var unicode_to_listen: String = "a"
@export var use_print_debug: bool = true
@export var last_input_found: String = ""

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		# return if repeating event
		if event.is_echo():
			return
		var key_event := event as InputEventKey
		if key_event.unicode == 0:
			return
		var unicode_char := char(key_event.unicode)
		last_input_found = unicode_char

		if use_print_debug:
			print("Key event unicode char: ", unicode_char, " unicode int: ", key_event.unicode, " IsOn: ", is_on() )

		if unicode_char == unicode_to_listen:
			notify_as_changed_state(key_event.pressed)
