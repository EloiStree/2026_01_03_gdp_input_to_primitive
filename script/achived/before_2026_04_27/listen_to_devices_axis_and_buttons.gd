class_name ListenToDevicesAxisAndButtons extends Node

signal on_new_device_tracked(device_index: int, apparition_index: int, device_name: String)
signal on_new_supposed_xbox_tracked(device_index: int, apparition_index: int, device_name: String)
signal on_axis_changed(device_index: int, apparition_index: int, axis_index: int, previous_axis_value: float, new_axis_value: float)
signal on_button_changed(device_index: int, apparition_index: int, button_index: int,  new_button_value: bool)
signal on_any_event_to_device_reference(device: DeviceTracked)
signal on_any_button_event_to_device_reference(device:DeviceTracked)
signal on_any_event_to_device_and_manager_reference(device: DeviceTracked, manager: ListenToDevicesAxisAndButtons)


@export var is_xbox_if_has_in_name: Array[String] = ["xbox","steam deck", "x-box", "x box", "xbox360", "x-box360", "x box360", "xbox one", "x-box one", "x box one" ]
@export var use_print_debug: bool = false


# on_new_device_tracked.emit( )
# on_new_supposed_xbox_tracked.emit()
# on_axis_changed.emit()
# on_button_changed.emit()
# on_any_event_to_device_reference.emit()
# on_any_event_to_device_and_manager_reference.emit()


var list_of_all_devices: Array[DeviceTracked] = []

func has_xbox_player() -> bool:
	for device in list_of_all_devices:
		if device == null:
			continue
		if device.is_xbox:
			return true
	return false

func get_xbox_players_count() -> int:
	var count := 0
	for device in list_of_all_devices:
		if device == null:
			continue
		if device.is_xbox:
			count += 1
	return count
func get_non_xbox_players_count() -> int:
	var count := 0
	for device in list_of_all_devices:
		if device == null:
			continue
		if not device.is_xbox:
			count += 1
	return count

func has_xbox_player_1_to_4(player_index_1_to_4: int) -> bool:
	return get_xbox_player_1_to_4(player_index_1_to_4) != null

func get_xbox_player_1_to_4(player_index_1_to_4: int) -> DeviceTracked:
	var count := 0
	var current_index := 1
	for device in list_of_all_devices:
		if device == null:
			continue
		if device.is_xbox:
			if device.joystick_apparition_index+1 == player_index_1_to_4:
				return device
	return null


func is_device_name_consider_xbox(device_name: String) -> bool:
	var lower_name := device_name.to_lower()
	for xbox_name_part in is_xbox_if_has_in_name:
		if xbox_name_part in lower_name:
			return true
	return false

func is_device_index_is_in_list_of_all_devices(device_index: int) -> bool:
	if device_index < 0:
		return false
	if device_index >= list_of_all_devices.size():
		return false
	return list_of_all_devices[device_index] != null

func _add_tracked_device(device_index: int) -> void:
	var bool_is_device_setup = device_index >= 0 and device_index < list_of_all_devices.size() and list_of_all_devices[device_index] != null
	if bool_is_device_setup:
		return
	var device_name := Input.get_joy_name(device_index)
	var device_apparition_index = get_exact_name_count_in_track_devices(device_name,true, true)
	if use_print_debug:
		print("Adding device with Godot index: ", device_index, " Apparition index: ", device_apparition_index, " Name: ", device_name)
	var is_xbox := is_device_name_consider_xbox(device_name)
	var new_device := DeviceTracked.new()
	new_device.is_xbox = is_xbox
	new_device.joystick_godot_index = device_index
	new_device.joystick_apparition_index = device_apparition_index
	new_device.joystick_name = device_name
	new_device.axis_list = []
	new_device.button_list = []


	# Resize the list to accommodate the new device index if necessary
	if device_index >= list_of_all_devices.size():
		list_of_all_devices.resize(device_index + 1)
	list_of_all_devices[device_index] = new_device


	on_new_device_tracked.emit(device_index, device_apparition_index, device_name)
	if is_xbox:
		on_new_supposed_xbox_tracked.emit(device_index, device_apparition_index, device_name)
	on_any_event_to_device_reference.emit(new_device)
	on_any_event_to_device_and_manager_reference.emit(new_device, self)



func get_exact_name_count_in_track_devices(device_name: String, use_lowercase: bool = true, use_trim: bool = true) -> int:
	var count := 0
	
	if use_trim:
		device_name = device_name.strip_edges()
	if use_lowercase:
		device_name = device_name.to_lower()

	
	for device in list_of_all_devices:
		if device == null:
			continue
		var name_to_check := device.joystick_name
		if use_trim:
			name_to_check = name_to_check.strip_edges()
		if use_lowercase:
			name_to_check = name_to_check.to_lower()
		if name_to_check == device_name:
			count += 1
	return count

func is_device_tracked(device_index: int) -> bool:
	if device_index < 0:
		return false
	if device_index >= list_of_all_devices.size():
		return false
	return list_of_all_devices[device_index] != null

func get_device_by_godot_index(device_index: int) -> DeviceTracked:
	if device_index < 0:
		return null
	if device_index >= list_of_all_devices.size():
		return null
	return list_of_all_devices[device_index]


func get_device_axis_by_godot_index(device_index: int, axis_index: int) -> DeviceAxis:
	var device := get_device_by_godot_index(device_index)
	if device == null:
		return null
	for axis in device.axis_list:
		if axis == null:
			continue
		if axis.axis_index == axis_index:
			return axis
	return null

func get_device_button_by_godot_index(device_index: int, button_index: int) -> DeviceButton:
	var device := get_device_by_godot_index(device_index)
	if device == null:
		return null
	for button in device.button_list:
		if button == null:
			continue
		if button.button_index == button_index:
			return button
	return null

func get_device_by_apparition_index(apparition_index: int) -> DeviceTracked:
	for device in list_of_all_devices:
		if device == null:
			continue
		if device.joystick_apparition_index == apparition_index:
			return device
	return null

func get_device_by_exact_name(device_name: String, use_lowercase: bool = true, use_trim: bool = true) -> Array[DeviceTracked]:
	var matching_devices: Array[DeviceTracked] = []
	for device in list_of_all_devices:
		if device == null:
			continue
		var name_to_check := device.joystick_name
		if use_trim:
			name_to_check = name_to_check.strip_edges()
		if use_lowercase:
			name_to_check = name_to_check.to_lower()
		if name_to_check == device_name:
				matching_devices.append(device)
	return matching_devices

func get_device_with_name_containing(device_name_part: String, use_lowercase: bool = true, use_trim: bool = true) -> Array[DeviceTracked]:
	var matching_devices: Array[DeviceTracked] = []
	for device in list_of_all_devices:
		if device == null:
			continue
		var name_to_check := device.joystick_name
		if use_trim:
			name_to_check = name_to_check.strip_edges()
		if use_lowercase:
			name_to_check = name_to_check.to_lower()
		if device_name_part in name_to_check:
			matching_devices.append(device)
	return matching_devices


func _set_axis_value_for_device(device_index: int, axis_index: int, axis_value: float) -> void:
	var is_tracked := is_device_tracked(device_index)
	if not is_tracked:
		_add_tracked_device(device_index)
	var device := get_device_by_godot_index(device_index)

	if device == null:
		return
	for axis in device.axis_list:
		if axis == null:
			continue
		if axis.axis_index == axis_index:
			var previous_axis_value := axis.axis_value
			axis.axis_value = axis_value
			on_axis_changed.emit(device_index, device.joystick_apparition_index, axis_index, previous_axis_value, axis_value)
			on_any_event_to_device_reference.emit(device)
			on_any_event_to_device_and_manager_reference.emit(device, self)
			return
	var new_axis := DeviceAxis.new()
	new_axis.linked_device = device
	new_axis.axis_name = "Axis " + str(axis_index)
	new_axis.axis_index = axis_index
	new_axis.axis_value = axis_value
	device.axis_list.append(new_axis)

	on_axis_changed.emit(device_index, device.joystick_apparition_index, axis_index, 0.0, axis_value)
	on_any_event_to_device_reference.emit(device)
	on_any_event_to_device_and_manager_reference.emit(device, self)

func get_device_name_by_godot_index(device_index: int) -> String:
	var device := get_device_by_godot_index(device_index)
	if device == null:
		return "Unknown Device "+str(device_index)
	return device.joystick_name



func _set_button_value_for_device(device_index: int, button_index: int, button_value: bool) -> void:
	var is_tracked := is_device_tracked(device_index)
	if not is_tracked:
		_add_tracked_device(device_index)
	var device := get_device_by_godot_index(device_index)
	if device == null:
		return
	for button in device.button_list:
		if button == null:
			continue
		if button.button_index == button_index:
			var previous_button_value := button.button_value
			button.button_value = button_value
			on_button_changed.emit(device_index, device.joystick_apparition_index, button_index,  button_value)
			on_any_event_to_device_reference.emit(device)
			on_any_button_event_to_device_reference.emit(device)
			on_any_event_to_device_and_manager_reference.emit(device, self)
			return

	var new_button := DeviceButton.new()
	new_button.linked_device = device
	new_button.button_name = "Button " + str(button_index)
	new_button.button_index = button_index
	new_button.button_value = button_value
	device.button_list.append(new_button)	
	on_button_changed.emit(device_index, device.joystick_apparition_index, button_index,  button_value)
	on_any_event_to_device_reference.emit(device)
	on_any_button_event_to_device_reference.emit(device)
	on_any_event_to_device_and_manager_reference.emit(device, self)

func get_one_line_description_for_device_godot_index(device_index: int) -> String:
	var device := get_device_by_godot_index(device_index)
	if device == null:
		return "Device not tracked "+str(device_index)+ " List size: "+str(list_of_all_devices.size())
	return device.get_one_line_description()

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion:
		var joy_event := event as InputEventJoypadMotion
		var device_index := joy_event.device
		var axis_index := joy_event.axis
		var axis_value := joy_event.axis_value
		var device_name := Input.get_joy_name(device_index)
		_set_axis_value_for_device(device_index, axis_index, axis_value)
		if use_print_debug:
			print(get_one_line_description_for_device_godot_index(device_index))

	elif event is InputEventJoypadButton:
		var button_event := event as InputEventJoypadButton
		var device_index := button_event.device
		var button_index := button_event.button_index
		var button_pressed := button_event.pressed
		var device_name := Input.get_joy_name(device_index)
		_set_button_value_for_device(device_index, button_index, button_pressed)
		if use_print_debug:
			print(get_one_line_description_for_device_godot_index(device_index))

class DeviceAxis:
	var linked_device: DeviceTracked
	var axis_name: String
	var axis_index: int
	var axis_value: float

	func get_axis_apparition_string_id_name() -> String:
		#>NAME|APPARITION_INDEX
		return "A>"+str(linked_device.joystick_name) + "|" + str(linked_device.joystick_apparition_index) + "|"+str(axis_index)
	
	func get_axis_apparition_string_id_name_with_gamepad_name() -> String:
		#>NAME|APPARITION_INDEX|DEFAULT_NAME
		return "A>"+str(linked_device.joystick_name) + "|" + str(linked_device.joystick_apparition_index) + "|"+str(axis_index) + "(" + get_axis_default_name() + ")"

	func get_axis_default_name() -> String:
		match axis_index:
			JOY_AXIS_TRIGGER_LEFT: return "Trigger Left"
			JOY_AXIS_TRIGGER_RIGHT: return "Trigger Right"
			JOY_AXIS_LEFT_X: return "Stick Left Horizontal"
			JOY_AXIS_LEFT_Y: return "Stick Left Vertical"
			JOY_AXIS_RIGHT_X: return "Stick Right Horizontal"
			JOY_AXIS_RIGHT_Y: return "Stick Right Vertical"
			_: return "Axis "+str(axis_index)
		


class DeviceButton:
	var linked_device: DeviceTracked
	var button_name: String
	var button_index: int
	var button_value: bool

	func get_button_apparition_string_id_name() -> String:
		#>NAME|APPARITION_INDEX
		return "B>"+str(linked_device.joystick_name) + "|" + str(linked_device.joystick_apparition_index) + "|"+str(button_index)

	func get_button_apparition_string_id_name_with_gamepad_name() -> String:
		#>NAME|APPARITION_INDEX|DEFAULT_NAME
		return "B>"+str(linked_device.joystick_name) + "|" + str(linked_device.joystick_apparition_index) + "|"+str(button_index) + "(" + get_button_default_name() + ")"

	func get_button_default_name() -> String:

		match button_index:
			JOY_BUTTON_A: return "A"
			JOY_BUTTON_B: return "B"
			JOY_BUTTON_X: return "X"
			JOY_BUTTON_Y: return "Y"
			JOY_BUTTON_BACK: return "Menu Left"
			JOY_BUTTON_START: return "Menu Right"
			JOY_BUTTON_LEFT_STICK: return "Joystick Left"
			JOY_BUTTON_RIGHT_STICK: return "Joystick Right"
			JOY_BUTTON_DPAD_UP: return "DPad Up"
			JOY_BUTTON_DPAD_DOWN: return "DPad Down"
			JOY_BUTTON_DPAD_LEFT: return "DPad Left"
			JOY_BUTTON_DPAD_RIGHT: return "DPad Right"
			JOY_BUTTON_LEFT_SHOULDER: return "Left Shoulder"
			JOY_BUTTON_RIGHT_SHOULDER: return "Right Shoulder"
			_: return "Button "+str(button_index)





class DeviceTracked:
	var is_xbox: bool
	var joystick_godot_index: int
	var joystick_apparition_index: int
	var joystick_name: String
	var axis_list: Array[DeviceAxis] = []
	var button_list: Array[DeviceButton] = []
	# End of script

	func get_apparition_string_id_name() -> String:
		#>NAME|APPARITION_INDEX
		return "D>"+str(joystick_name) + "|" + str(joystick_apparition_index)


	func get_one_line_description() -> String:
		# GODOT_INDEX|APPARITION_INDEX|IS_XBOX|NAME| A1 0.00 ::: B2 1.00 ::: 
		var description := str(joystick_godot_index) + "|" + str(joystick_apparition_index) + "|" + str(is_xbox) + "|" + joystick_name + "| "
		for axis in axis_list:
			if axis == null:
				continue
			description += "A" + str(axis.axis_index) + " " + str(axis.axis_value) + ", "
		for button in button_list:
			if button == null:
				continue	
			description += "B" + str(button.button_index) + " " + str(button.button_value) + ", "
		return description

	func get_axis_value_by_axis_index(axis_index: int) -> float:
		for axis in axis_list:
			if axis == null:
				continue
			if axis.axis_index == axis_index:
				return axis.axis_value
		return 0.0

	func get_button_value_by_button_index(button_index: int) -> bool:
		for button in button_list:
			if button == null:
				continue
			if button.button_index == button_index:
				return button.button_value
		return false

	func get_gamepad_axis_trigger_left() -> float:
		return get_axis_value_by_axis_index(JOY_AXIS_TRIGGER_LEFT)

	func get_gamepad_axis_trigger_right() -> float:
		return get_axis_value_by_axis_index(JOY_AXIS_TRIGGER_RIGHT)
	func get_gamepad_axis_left_x() -> float:
		return get_axis_value_by_axis_index(JOY_AXIS_LEFT_X)
	func get_gamepad_axis_left_y() -> float:
		return get_axis_value_by_axis_index(JOY_AXIS_LEFT_Y)
	func get_gamepad_axis_right_x() -> float:
		return get_axis_value_by_axis_index(JOY_AXIS_RIGHT_X)
	func get_gamepad_axis_right_y() -> float:
		return get_axis_value_by_axis_index(JOY_AXIS_RIGHT_Y)
	func get_gamepad_button_a() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_A)
	func get_gamepad_button_b() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_B)
	func get_gamepad_button_x() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_X)
	func get_gamepad_button_y() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_Y)
	func get_gamepad_button_back() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_BACK)
	func get_gamepad_button_start() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_START)
	func get_gamepad_button_left_stick() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_LEFT_STICK)
	func get_gamepad_button_right_stick() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_RIGHT_STICK)
	func get_gamepad_button_dpad_up() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_DPAD_UP)
	func get_gamepad_button_dpad_down() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_DPAD_DOWN)
	func get_gamepad_button_dpad_left() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_DPAD_LEFT)
	func get_gamepad_button_dpad_right() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_DPAD_RIGHT)
	func get_gamepad_button_left_shoulder() -> bool:
		return get_button_value_by_button_index(JOY_BUTTON_LEFT_SHOULDER)
	func get_gamepad_button_right_shoulder() -> bool:	
		return get_button_value_by_button_index(JOY_BUTTON_RIGHT_SHOULDER)
