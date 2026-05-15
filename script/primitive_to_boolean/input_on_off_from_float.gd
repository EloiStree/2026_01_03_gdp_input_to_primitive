class_name InputOnOffFromFloat
extends InputAbstractOnOffEmit

signal on_float_value_updated(value: float)
signal on_float_value_changed(value: float)

@export var range_min: float = 0.0
@export var range_max: float = 1.0
@export var inverse_boolean_result: bool = false

@export_group("Debug")
@export var last_value_fetched: float = 0.0
@export var last_value_is_in_range: bool = false

func push_in(value: float) -> void:
	var changed = value != last_value_fetched
	last_value_fetched = value
	
	var is_value_between = value >= range_min and value <= range_max
	
	if inverse_boolean_result:
		is_value_between = not is_value_between
	last_value_is_in_range = is_value_between
	notify_as_changed_state(value)

	if changed:
		on_float_value_changed.emit(value)

	on_float_value_updated.emit(value)
