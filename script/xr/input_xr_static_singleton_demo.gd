class_name InputXrStaticSingletonDemo
extends Node

signal on_debug_text_emitted(debug_text: String)
@export var debug_label: Label3D

func _process(delta: float) -> void:

	var head_position :Vector3= InputXrStaticSingleton.get_head_global_position()
	var head_rotation :Vector3= InputXrStaticSingleton.get_head_global_euler_rotation()
	
	var left_hand_position :Vector3= InputXrStaticSingleton.get_left_hand_global_position()
	var right_hand_position :Vector3= InputXrStaticSingleton.get_right_hand_global_position()
	
	var left_hand_rotation :Vector3= InputXrStaticSingleton.get_left_controller_global_euler_rotation()
	var right_hand_rotation :Vector3= InputXrStaticSingleton.get_right_controller_global_euler_rotation()
	

	# frist line left and right position
	var line_one:String="Head Position: " + str(head_position) + " - " + "Left Hand Position: " + str(left_hand_position) + " - " + "Right Hand Position: " + str(right_hand_position) + ""
	# second line euleur left and right position
	var line_two:String="Head Rotation: " + str(head_rotation) + " - " + "Left Hand Rotation: " + str(left_hand_rotation) + " -" + "Right Hand Rotation: " + str(right_hand_rotation) + ""

	var a =InputXrStaticSingleton.get_button_right_down_a_press()
	var b =InputXrStaticSingleton.get_button_right_up_b_press()
	var x =InputXrStaticSingleton.get_button_left_down_x_press()
	var y =InputXrStaticSingleton.get_button_left_up_y_press()
	var line_button_abxy:String="Button A: " + str(a) + " - " + "Button B: " + str(b) + " - " + "Button X: " + str(x) + " - " + "Button Y: " + str(y)

	var trigger_left = InputXrStaticSingleton.get_trigger_left_value()
	var trigger_right = InputXrStaticSingleton.get_trigger_right_value()
	var grip_left = InputXrStaticSingleton.get_grip_left_value()
	var grip_right = InputXrStaticSingleton.get_grip_right_value()
	var line_trigger_grip:String="Trigger Left: " + str(trigger_left) + " - " + "Trigger Right: " + str(trigger_right) + " - " + "Grip Left: " + str(grip_left) + " - " + "Grip Right: " + str(grip_right)

	var joystick_left = InputXrStaticSingleton.get_left_joystick_2d_value()
	var joystick_right = InputXrStaticSingleton.get_right_joystick_2d_value()
	var joystick_left_click = InputXrStaticSingleton.get_left_joystick_button_press()
	var joystick_right_click = InputXrStaticSingleton.get_right_joystick_button_press()
	var line_joystick:String="Joystick Left: " + str(joystick_left) + " - " + "Joystick Right: " + str(joystick_right) + " - " + "Joystick Left Click: " + str(joystick_left_click) + " - " + "Joystick Right Click: " + str(joystick_right_click)	


	var touch_a = InputXrStaticSingleton.get_button_right_down_a_touch()
	var touch_b = InputXrStaticSingleton.get_button_right_up_b_touch()
	var touch_x = InputXrStaticSingleton.get_button_left_down_x_touch()
	var touch_y = InputXrStaticSingleton.get_button_left_up_y_touch()
	var touch_trigger_left = InputXrStaticSingleton.get_left_trigger_touch()
	var touch_trigger_right = InputXrStaticSingleton.get_right_trigger_touch()
	var line_touch:String="Touch A: " + str(touch_a) + " - " + "Touch B: " + str(touch_b) + " - " + "Touch X: " + str(touch_x) + " - " + "Touch Y: " + str(touch_y) + " - " + "Touch Trigger Left: " + str(touch_trigger_left) + " - " + "Touch Trigger Right: " + str(touch_trigger_right)	


	var touch_pad_left = InputXrStaticSingleton.get_left_touch_pad_joystick_2d()
	var touch_pad_right = InputXrStaticSingleton.get_right_touch_pad_joystick_2d()
	var touch_pad_left_touch = InputXrStaticSingleton.get_left_touch_pad_click_or_touch()
	var touch_pad_right_touch = InputXrStaticSingleton.get_right_touch_pad_click_or_touch()	
	var line_touch_pad:String="Touch Pad Left: " + str(touch_pad_left) + " - " + "Touch Pad Right: " + str(touch_pad_right) + " - " + "Touch Pad Left Touch: " + str(touch_pad_left_touch) + " - " + "Touch Pad Right Touch: " + str(touch_pad_right_touch)


	var is_hand_tracked_left = InputXrStaticSingleton.is_left_hand_tracked()
	var is_hand_tracked_right = InputXrStaticSingleton.is_right_hand_tracked()
	var line_hand_tracked:String="Is Left Hand Tracked: " + str(is_hand_tracked_left) + " - " + "Is Right Hand Tracked: " + str(is_hand_tracked_right) + ""


	# var string_to_display:String ='\n'.join([line_one, line_two, line_button_abxy])
	# var string_to_display:String ='\n'.join([line_touch_pad])
	var string_to_display:String ='\n'.join([line_one, line_two, line_button_abxy, line_trigger_grip, line_joystick, line_touch, line_touch_pad, line_hand_tracked])
	if debug_label:
		debug_label.text = string_to_display
	on_debug_text_emitted.emit( string_to_display)
