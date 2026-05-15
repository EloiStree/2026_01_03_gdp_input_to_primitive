class_name InputParseArrowFromVector2
extends Node

signal on_vector2_value_updated(value: Vector2)

signal on_arrow_updated(up: bool, right: bool, down: bool, left: bool)
signal on_arrow_changed(up: bool, right: bool, down: bool, left: bool)
signal on_left_arrow_changed(is_pressed: bool)
signal on_right_arrow_changed(is_pressed: bool)
signal on_up_arrow_changed(is_pressed: bool)
signal on_down_arrow_changed(is_pressed: bool)


@export var radius_threshold: float = 0.35


@export_group("Debug")
@export var last_value_fetched: Vector2 = Vector2.ZERO
@export var last_arrow_left: bool = false
@export var last_arrow_right: bool = false
@export var last_arrow_up: bool = false
@export var last_arrow_down: bool = false




func push_in_vector2(value: Vector2	) -> void:
	var changed = value != last_value_fetched
	last_value_fetched = value

	var is_left = value.x < -radius_threshold
	var is_right = value.x > radius_threshold	
	var is_up = value.y > radius_threshold
	var is_down = value.y < -radius_threshold
	var one_changed=is_left != last_arrow_left or is_right != last_arrow_right or is_up != last_arrow_up or is_down != last_arrow_down

	if is_left != last_arrow_left:
		last_arrow_left = is_left
		on_left_arrow_changed.emit(is_left)
	if is_right != last_arrow_right:
		last_arrow_right = is_right
		on_right_arrow_changed.emit(is_right)
	if is_up != last_arrow_up:
		last_arrow_up = is_up
		on_up_arrow_changed.emit(is_up)
	if is_down != last_arrow_down:
		last_arrow_down = is_down
		on_down_arrow_changed.emit(is_down)

	if one_changed:
		on_arrow_changed.emit(is_up, is_right, is_down, is_left)
	on_arrow_updated.emit(is_up, is_right, is_down, is_left)
	on_vector2_value_updated.emit(value)


# func is_between_threshold(value:float, min:float, max:float) -> bool:
# 	if min > max:
# 		var temp = min
# 		min = max
# 		max = temp
# 	return value >= min and value <= max
	
