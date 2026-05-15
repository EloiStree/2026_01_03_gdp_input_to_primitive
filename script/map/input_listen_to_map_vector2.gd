class_name InputListenToMapVector2
extends InputAbstractOnOffEmit

signal on_float_value_updated(value: Vector2)
signal on_float_value_changed(value: Vector2)

@export var input_map_negative_horizontal := ""
@export var input_map_positive_horizontal := ""
@export var input_map_negative_vertical := ""
@export var input_map_positive_vertical := ""


@export_group("Debug")
@export var last_value_fetched: Vector2 = Vector2.ZERO
@export var last_value_is_in_range: bool = false

@export var last_right_value: float = 0.0
@export var last_left_value: float = 0.0
@export var last_up_value: float = 0.0
@export var last_down_value: float = 0.0


func _ready() -> void:
	check_and_notify_value()


func _process(_delta: float) -> void:
	check_and_notify_value()


func check_and_notify_value():
	if input_map_negative_horizontal == "" or input_map_positive_horizontal == "" or input_map_negative_vertical == "" or input_map_positive_vertical == "":
		return

	if InputMap.has_action(input_map_negative_horizontal):
		last_left_value = Input.get_action_strength(input_map_negative_horizontal)

	if InputMap.has_action(input_map_positive_horizontal):
		last_right_value = Input.get_action_strength(input_map_positive_horizontal)

	if InputMap.has_action(input_map_negative_vertical):
		last_down_value = Input.get_action_strength(input_map_negative_vertical)

	if InputMap.has_action(input_map_positive_vertical):
		last_up_value = Input.get_action_strength(input_map_positive_vertical)

	var current_value := Vector2(last_right_value - last_left_value, last_up_value - last_down_value)
	var value_changed := current_value != last_value_fetched
	last_value_fetched = current_value
	if value_changed:
		on_float_value_changed.emit(current_value)
	on_float_value_updated.emit(current_value)
