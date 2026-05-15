class_name InputListenToMapButton
extends InputAbstractOnOffEmit
@export var input_map_named=""

func _ready() -> void:
	check_and_notify_value()	


func _process(_delta: float) -> void:
	check_and_notify_value()

func check_and_notify_value():
	if input_map_named=="":
		return
	var current_value = Input.is_action_pressed(input_map_named)
	if current_value != is_on():
		notify_as_changed_state(current_value)
