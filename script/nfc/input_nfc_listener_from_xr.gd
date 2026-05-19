class_name InputNfcListenerRefFromXr
extends Node

@export var nfc: InputNfcListener

@export_group("Debug")
@export var p_button_a: bool
@export var p_button_b: bool
@export var p_button_x: bool
@export var p_button_y: bool
@export var p_button_menu: bool

@export var p_trigger_left: bool
@export var p_trigger_right: bool
@export var p_grip_left: bool
@export var p_grip_right: bool

@export var p_joystick_left: Vector2
@export var p_joystick_right: Vector2


@export var p_joy_left_left: bool
@export var p_joy_left_right: bool
@export var p_joy_left_up: bool
@export var p_joy_left_down: bool

@export var p_joy_right_left: bool
@export var p_joy_right_right: bool
@export var p_joy_right_up: bool
@export var p_joy_right_down: bool

@export var p_joy_left_click: bool
@export var p_joy_right_click: bool



func _process(delta: float) -> void:
	# Read raw input
	var s_button_a = get_button_right_down_a_press()
	var s_button_b = get_button_right_up_b_press()
	var s_button_x = get_button_left_down_x_press()
	var s_button_y = get_button_left_up_y_press()
	var s_button_menu = get_button_menu_left_press()
	
	var s_trigger_left = get_trigger_left_value()> 0.5
	var s_trigger_right = get_trigger_right_value()> 0.5
	var s_grip_left = get_grip_left_value()> 0.5
	var s_grip_right = get_grip_right_value()> 0.5
	
	var s_jl = get_left_joystick_2d_value()
	var s_jr = get_right_joystick_2d_value()
	
	# Joystick cardinal directions (with hysteresis/deadzone)
	var s_joy_left_left  = s_jl.x < -0.5
	var s_joy_left_right = s_jl.x > 0.5
	var s_joy_left_up    = s_jl.y > 0.5
	var s_joy_left_down  = s_jl.y < -0.5
	
	var s_joy_right_left  = s_jr.x < -0.5
	var s_joy_right_right = s_jr.x > 0.5
	var s_joy_right_up    = s_jr.y > 0.5
	var s_joy_right_down  = s_jr.y < -0.5

	# Joystick click
	var s_joy_left_click = get_joystick_left_click()
	var s_joy_right_click = get_joystick_right_click()

	if p_button_a!= s_button_a:
		nfc.append_text_to_builder_with_spliter("XRA")
	if p_button_b!= s_button_b:
		nfc.append_text_to_builder_with_spliter("XRB")
	if p_button_x!= s_button_x:
		nfc.append_text_to_builder_with_spliter("XRX")
	if p_button_y!= s_button_y:
		nfc.append_text_to_builder_with_spliter("XRY")
	if p_button_menu!= s_button_menu:
		nfc.append_text_to_builder_with_spliter("XRM")
	if p_trigger_left!= s_trigger_left:
		nfc.append_text_to_builder_with_spliter("XRLT")
	if p_trigger_right!= s_trigger_right:
		nfc.append_text_to_builder_with_spliter("XRRT")
	if p_grip_left!= s_grip_left:
		nfc.append_text_to_builder_with_spliter("XRLG")
	if p_grip_right!= s_grip_right:
		nfc.append_text_to_builder_with_spliter("XRRG")
	if p_joy_left_down!= s_joy_left_down:
		nfc.append_text_to_builder_with_spliter("XRLD")
	if p_joy_left_up!= s_joy_left_up:
		nfc.append_text_to_builder_with_spliter("XRLU")
	if p_joy_left_left!= s_joy_left_left:
		nfc.append_text_to_builder_with_spliter("XRLL")
	if p_joy_left_right!= s_joy_left_right:
		nfc.append_text_to_builder_with_spliter("XRLR")
	if p_joy_right_down!= s_joy_right_down:
		nfc.append_text_to_builder_with_spliter("XRRD")
	if p_joy_right_up!= s_joy_right_up:
		nfc.append_text_to_builder_with_spliter("XRRU")
	if p_joy_right_left!= s_joy_right_left:
		nfc.append_text_to_builder_with_spliter("XRRL")
	if p_joy_right_right!= s_joy_right_right:
		nfc.append_text_to_builder_with_spliter("XRRR")
	if p_joy_left_click!= s_joy_left_click:
		nfc.append_text_to_builder_with_spliter("XRLC")
	if p_joy_right_click!= s_joy_right_click:
		nfc.append_text_to_builder_with_spliter("XRRC")


	# Sync to exported properties (visible in editor / inspector)
	p_button_a = s_button_a
	p_button_b = s_button_b
	p_button_x = s_button_x
	p_button_y = s_button_y
	p_button_menu = s_button_menu
	
	p_trigger_left = s_trigger_left
	p_trigger_right = s_trigger_right
	p_grip_left = s_grip_left
	p_grip_right = s_grip_right
	
	p_joy_left_left = s_joy_left_left
	p_joy_left_right = s_joy_left_right
	p_joy_left_up = s_joy_left_up
	p_joy_left_down = s_joy_left_down
	
	p_joy_right_left = s_joy_right_left
	p_joy_right_right = s_joy_right_right
	p_joy_right_up = s_joy_right_up
	p_joy_right_down = s_joy_right_down

	p_joy_left_click = s_joy_left_click
	p_joy_right_click = s_joy_right_click




@export_group("Found")
@export var xr_origin: XROrigin3D
@export var xr_camera: XRCamera3D
@export var xr_left_controller: XRController3D
@export var xr_right_controller: XRController3D

func _ready() -> void:
	var all_nodes := get_all_nodes_of_scene()
	find_xr_elements_in_nodes(all_nodes)
	
	if not xr_origin:
		push_warning("XR Origin not found!")
	if not xr_camera:
		push_warning("XR Camera not found!")
	if not xr_left_controller:
		push_warning("XR Left Controller not found!")
	if not xr_right_controller:
		push_warning("XR Right Controller not found!")


func get_all_nodes_of_scene() -> Array[Node]:
	var nodes: Array[Node] = []
	_collect_nodes_recursive(get_tree().root, nodes)
	return nodes


func _collect_nodes_recursive(node: Node, collected: Array[Node]) -> void:
	if not node:
		return
	collected.append(node)
	for child in node.get_children():
		_collect_nodes_recursive(child, collected)


func find_xr_elements_in_nodes(nodes: Array[Node]) -> void:
	for node in nodes:
		if not node:
			continue
			
		if not xr_origin and node is XROrigin3D:
			xr_origin = node
		elif not xr_camera and node is XRCamera3D:
			xr_camera = node
		elif node is XRController3D:
			var controller := node as XRController3D
			if controller.tracker == "left_hand" or controller.name.to_lower().contains("left"):
				if not xr_left_controller:
					xr_left_controller = controller
			elif controller.tracker == "right_hand" or controller.name.to_lower().contains("right"):
				if not xr_right_controller:
					xr_right_controller = controller
		
		if xr_origin and xr_camera and xr_left_controller and xr_right_controller:
			break


# ================================================================
# Input getters (already present + minor improvements)
# ================================================================

func get_button_left_down_x_press() -> bool:
	if not xr_left_controller: return false
	return xr_left_controller.is_button_pressed("ax_button") or xr_left_controller.is_button_pressed("x_button")


func get_button_left_up_y_press() -> bool:
	if not xr_left_controller: return false
	return xr_left_controller.is_button_pressed("by_button") or xr_left_controller.is_button_pressed("y_button")


func get_button_right_down_a_press() -> bool:
	if not xr_right_controller: return false
	return xr_right_controller.is_button_pressed("ax_button") or xr_right_controller.is_button_pressed("a_button")


func get_button_right_up_b_press() -> bool:
	if not xr_right_controller: return false
	return xr_right_controller.is_button_pressed("by_button") or xr_right_controller.is_button_pressed("b_button")


func get_button_menu_left_press() -> bool:
	if not xr_left_controller: return false
	return xr_left_controller.is_button_pressed("menu_button")


func get_left_joystick_2d_value() -> Vector2:
	if not xr_left_controller:
		return Vector2.ZERO
	for name in ["primary", "thumbstick", "joystick", "secondary"]:
		var value = xr_left_controller.get_vector2(name)
		if value.length() > 0.05:   # slightly larger deadzone for stability
			return value
	return Vector2.ZERO


func get_right_joystick_2d_value() -> Vector2:
	if not xr_right_controller:
		return Vector2.ZERO
	for name in ["primary", "thumbstick", "joystick", "secondary"]:
		var value = xr_right_controller.get_vector2(name)
		if value.length() > 0.05:
			return value
	return Vector2.ZERO


func get_trigger_left_value() -> float:
	return get_float(xr_left_controller, "trigger")


func get_trigger_right_value() -> float:
	return get_float(xr_right_controller, "trigger")


func get_grip_left_value() -> float:
	return get_float(xr_left_controller, "grip")


func get_grip_right_value() -> float:
	return get_float(xr_right_controller, "grip")


func get_joystick_left_click() -> bool:
	return is_pressed(xr_left_controller, "joystick_click") or is_pressed(xr_left_controller, "thumbstick_click") or is_pressed(xr_left_controller, "primary_click")

func get_joystick_right_click() -> bool:
	return is_pressed(xr_right_controller, "joystick_click") or is_pressed(xr_right_controller, "thumbstick_click") or is_pressed(xr_right_controller, "primary_click")


func get_float(hand: XRController3D, action_name: String) -> float:
	return hand.get_float(action_name) if hand else 0.0


func get_vector2(hand: XRController3D, action_name: String) -> Vector2:
	return hand.get_vector2(action_name) if hand else Vector2.ZERO


func is_pressed(hand: XRController3D, action_name: String) -> bool:
	return hand.is_button_pressed(action_name) if hand else false
