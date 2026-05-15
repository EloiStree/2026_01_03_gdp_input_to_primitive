extends Node
class_name DebugJoystickListAsText

signal on_refresh_debug_text(text: String)

func get_axis_count(device_id: int) -> int:
	var count: int = 0
	for axis in range(JOY_AXIS_MAX):
		var value := Input.get_joy_axis(device_id, axis)
		if value != 0.0:
			count += 1
	return count

func get_button_count(device_id: int) -> int:
	var count: int = 0
	for button in range(JOY_BUTTON_MAX):
		if Input.is_joy_button_pressed(device_id, button):
			count += 1
	return count

func get_axis_states(device_id: int) -> Dictionary:
	var states := {}
	for axis in range(JOY_AXIS_MAX):
		var value := Input.get_joy_axis(device_id, axis)
		states[axis] = value
	return states

func get_button_states(device_id: int) -> Dictionary:
	var states := {}
	for button in range(JOY_BUTTON_MAX):
		states[button] = Input.is_joy_button_pressed(device_id, button)
	return states


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion or event is InputEventMouseButton:
		# Ignore mouse events
		print ("Mouse Event: %s" % event.as_text())
		return
	if event is InputEventKey:
		# Ignore keyboard events
		print ("Keyboard Event: %s" % event.as_text())
		return
		

	var device_id := event.get_device()
	var device_name := Input.get_joy_name(device_id)
	var description := event.as_text()

	print("Input Event from device %d (%s): %s" % [device_id, device_name, description])


	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		# Refresh the joystick list text when a joypad motion or button event occurs
		#print(event.as_text())
		_process(0)  # Call _process to update the text immediately


func _process(_delta: float) -> void:
	var text := "Joystick List:\n"
	var joypads := Input.get_connected_joypads()
	for i in range(joypads.size()):
		var device_id := joypads[i]
		var name := Input.get_joy_name(device_id)
		var axis_count: int = get_axis_count(device_id)
		var button_count: int = get_button_count(device_id)
		text += "Joystick %d: %s | Axis Count: %d | Button Count: %d\n" % [
			i + 1,
			name,
			axis_count,
			button_count
		]

	on_refresh_debug_text.emit(text)
