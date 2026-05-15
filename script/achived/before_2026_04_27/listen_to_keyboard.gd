


class_name ListenToKeyboard
extends Node

signal on_first_time_key_on(key_code: int)
signal on_key_on_off(key_code: int, value_is_down: bool)
signal on_key_on_off_with_label(key_code: int, label_name: String, value_is_down: bool)

# Tracks the current state of any key
var _key_states := {}
var keys_id_to_label_name: Dictionary = {}

@export var dictionary_key_id_to_label_name_to_load: Dictionary[int,String] = {}
@export var default_key_to_label_to_load: Array[KeyboardToolbox.IntegerIdToName] = []

func _ready() -> void:
	for key_to_label in default_key_to_label_to_load:
		if key_to_label != null:
			set_label_of_key_id(key_to_label.integer_value, key_to_label.name_value)
	for key_id in dictionary_key_id_to_label_name_to_load.keys():
		if key_id !=null:
			var label_name = dictionary_key_id_to_label_name_to_load[key_id]
			if label_name != null:
				set_label_of_key_id(key_id, label_name)

func _input(event):
	if event is InputEventKey:
		var key_code = event.keycode
		var is_down = event.pressed

		# Initialize the key state if not tracked yet
		if not _key_states.has(key_code):
			_key_states[key_code] = false

		# Detect first time the key is pressed
		if is_down and not _key_states[key_code]:
			on_first_time_key_on.emit(key_code)

		if _key_states[key_code] != is_down:
			_key_states[key_code] = is_down
			on_key_on_off.emit( key_code, is_down)
			on_key_on_off_with_label.emit( key_code, get_label_of_key_id(key_code), is_down)

func is_key_down(key_code: int) -> bool:
	return _key_states.get(key_code, false)
	
func set_label_of_key_id(key_id: int, label_name: String) -> void:
		keys_id_to_label_name[key_id] = label_name

func get_label_of_key_id(key_id: int) -> String:
	return keys_id_to_label_name.get(key_id, "")
