class_name InputListenToMapFloat11
extends InputAbstractOnOffEmit

signal on_float_value_updated(value: float)
signal on_float_value_changed(value: float)

@export var input_map_negative := ""
@export var input_map_positive := ""


@export_group("Debug")
@export var last_value_fetched: float = 0.0
@export var last_value_is_in_range: bool = false


func _ready() -> void:
	check_and_notify_value()


func _process(_delta: float) -> void:
	check_and_notify_value()


func check_and_notify_value():
	if input_map_negative == "" or input_map_positive == "":
		return

	var current_value := Input.get_axis(
		input_map_negative,
		input_map_positive
	)
	var value_changed := current_value != last_value_fetched
	last_value_fetched = current_value
	if value_changed:
		on_float_value_changed.emit(current_value)
	on_float_value_updated.emit(current_value)
