class_name InputXrStaticSingleton
extends Node

@export var local_origin: XROrigin3D
@export var local_head: XRController3D     # Usually the camera rig / head tracker
@export var local_left_controller: XRController3D
@export var local_right_controller: XRController3D
@export var local_camera_3d: XRCamera3D
@export var local_left_hand: XRNode3D
@export var local_right_hand: XRNode3D

@export var local_is_hands_tracked:InputXrIsHandTracked


# Static references (set once in _ready)
static var _static_origin: XROrigin3D
static var _static_head: XRController3D
static var _static_left_controller: XRController3D
static var _static_right_controller: XRController3D
static var _static_camera_3d: XRCamera3D
static var _static_left_hand: XRNode3D
static var _static_right_hand: XRNode3D
static var _static_is_hands_tracked:InputXrIsHandTracked

func _ready() -> void:
	print("InputXrStaticSingleton ready. Caching XR node references.")
	_static_origin = local_origin
	_static_head = local_head
	_static_left_controller = local_left_controller
	_static_right_controller = local_right_controller
	_static_camera_3d = local_camera_3d

	_static_left_hand = local_left_hand
	_static_right_hand = local_right_hand

	print("Cached XR Nodes:")
	print("Origin: ", _static_origin)	
	print("Head: ", _static_head)
	print("Left Controller: ", _static_left_controller)
	print("Right Controller: ", _static_right_controller)	
	print("Camera3D: ", _static_camera_3d)

func _init() -> void:
	print("InputXrStaticSingleton initialized. Make sure to set the exported node references in the inspector.")
	_static_origin = local_origin
	_static_head = local_head
	_static_left_controller = local_left_hand
	_static_right_controller = local_right_hand
	_static_camera_3d = local_camera_3d
	_static_left_hand = local_left_hand
	_static_right_hand = local_right_hand



#region GETTERS FOR XR NODES (returns null if not set)
static func get_head() -> XRController3D:
	return _static_head	

static func get_left_controller() -> XRController3D:
	return _static_left_controller

static func get_right_controller() -> XRController3D:
	return _static_right_controller

static func get_origin() -> XROrigin3D:
	return _static_origin

static func get_camera_3d() -> XRCamera3D:
	return _static_camera_3d

static func get_hand_left() -> XRNode3D:
	return _static_left_hand

static func get_hand_right() -> XRNode3D:
	return _static_right_hand


static func get_head_as_node_3d() -> Node3D:
	return _static_head	

static func get_left_controller_as_node_3d() -> Node3D:
	return _static_left_controller

static func get_right_controller_as_node_3d() -> Node3D:
	return _static_right_controller

static func get_origin_as_node_3d() -> Node3D:
	return _static_origin

static func get_camera_3d_as_node_3d() -> Node3D:
	return _static_camera_3d

static func get_left_hand_as_node_3d() -> Node3D:
	return _static_left_hand

static func get_right_hand_as_node_3d() -> Node3D:
	return _static_right_hand	

#endregion


#region GET TRANSFORM, POSITION, ROTATION OF XR NODES

static func get_head_global_transform() -> Transform3D:
	if not _static_head: return Transform3D.IDENTITY
	return _static_head.global_transform

static func get_left_controller_global_transform() -> Transform3D:
	if not _static_left_controller: return Transform3D.IDENTITY
	return _static_left_controller.global_transform

static func get_right_controller_global_transform() -> Transform3D:
	if not _static_right_controller: return Transform3D.IDENTITY
	return _static_right_controller.global_transform


static func get_left_hand_global_transform() -> Transform3D:
	if not _static_left_hand: return Transform3D.IDENTITY
	return _static_left_hand.global_transform	

static func get_right_hand_global_transform() -> Transform3D:
	if not _static_right_hand: return Transform3D.IDENTITY
	return _static_right_hand.global_transform	

static func get_origin_global_transform() -> Transform3D:
	if not _static_origin: return Transform3D.IDENTITY
	return _static_origin.global_transform

static func get_camera_3d_global_transform() -> Transform3D:
	if not _static_camera_3d: return Transform3D.IDENTITY
	return _static_camera_3d.global_transform

#endregion


#region GET POSITION 


static func get_left_controller_global_position() -> Vector3:
	if not _static_left_controller: return Vector3.ZERO
	return _static_left_controller.global_position

static func get_right_controller_global_position() -> Vector3:
	if not _static_right_controller: return Vector3.ZERO
	return _static_right_controller.global_position

static func get_head_global_position() -> Vector3:
	if not _static_head: return Vector3.ZERO
	return _static_head.global_position

static func get_origin_global_position() -> Vector3:
	if not _static_origin: return Vector3.ZERO
	return _static_origin.global_position

static func get_camera_3d_global_position() -> Vector3:
	if not _static_camera_3d: return Vector3.ZERO
	return _static_camera_3d.global_position


static func get_left_hand_global_position() -> Vector3:
	if not _static_left_hand: return Vector3.ZERO
	return _static_left_hand.global_position

static func get_right_hand_global_position() -> Vector3:
	if not _static_right_hand: return Vector3.ZERO
	return _static_right_hand.global_position	

#endregion


#region GET BASIS
static func get_left_controller_global_rotation() -> Basis:
	if not _static_left_controller: return Basis.IDENTITY
	return _static_left_controller.global_transform.basis

static func get_right_controller_global_rotation() -> Basis:
	if not _static_right_controller: return Basis.IDENTITY
	return _static_right_controller.global_transform.basis


#endregion


#region GET EULER
static func get_left_controller_global_euler_rotation() -> Vector3:
	if not _static_left_controller: return Vector3.ZERO
	return _static_left_controller.global_transform.basis.get_euler()

static func get_right_controller_global_euler_rotation() -> Vector3:
	if not _static_right_controller: return Vector3.ZERO
	return _static_right_controller.global_transform.basis.get_euler()

static func get_head_global_euler_rotation() -> Vector3:
	if not _static_head: return Vector3.ZERO
	return _static_head.global_transform.basis.get_euler()

static func get_origin_global_euler_rotation() -> Vector3:
	if not _static_origin: return Vector3.ZERO
	return _static_origin.global_transform.basis.get_euler()

static func get_camera_3d_global_euler_rotation() -> Vector3:
	if not _static_camera_3d: return Vector3.ZERO
	return _static_camera_3d.global_transform.basis.get_euler()

#endregion


#region GET QUATERNION

static func get_left_hand_global_quaternion_rotation() -> Quaternion:
	if not _static_left_hand: return Quaternion.IDENTITY	
	return Quaternion.from_euler(_static_left_hand.global_transform.basis.get_euler())
	

static func get_right_hand_global_quaternion_rotation() -> Quaternion:
	if not _static_right_hand: return Quaternion.IDENTITY	
	return Quaternion.from_euler(_static_right_hand.global_transform.basis.get_euler())


static func get_left_controller_global_quaternion_rotation() -> Quaternion:
	if not _static_left_controller: return Quaternion.IDENTITY
	return Quaternion.from_euler(_static_left_controller.global_transform.basis.get_euler())

static func get_right_controller_global_quaternion_rotation() -> Quaternion:
	if not _static_right_controller: return Quaternion.IDENTITY
	return Quaternion.from_euler(_static_right_controller.global_transform.basis.get_euler())
	
static func get_head_global_quaternion_rotation() -> Quaternion:	
	if not _static_head: return Quaternion.IDENTITY
	return Quaternion.from_euler(_static_head.global_transform.basis.get_euler())

static func get_origin_global_quaternion_rotation() -> Quaternion:
	if not _static_origin: return Quaternion.IDENTITY
	return Quaternion.from_euler(_static_origin.global_transform.basis.get_euler())

static func get_camera_3d_global_quaternion_rotation() -> Quaternion:
	if not _static_camera_3d: return Quaternion.IDENTITY
	return Quaternion.from_euler(_static_camera_3d.global_transform.basis.get_euler())



#endregion



#region  GET VALUE OF CONTROLLER


static func is_left_hand_tracked()-> bool:
	if not _static_is_hands_tracked: return false
	return _static_is_hands_tracked.is_left_hand_tracked()

static func is_right_hand_tracked()-> bool:
	if not _static_is_hands_tracked: return false
	return _static_is_hands_tracked.is_right_hand_tracked()

# =============================================================================
# TRIGGERS & GRIP (Float 0.0 - 1.0)
# =============================================================================


## Returns trigger squeeze value on the left controller (0.0 = not pressed, 1.0 = fully pressed)
static func get_trigger_left_value() -> float:
	if not _static_left_controller: return 0.0
	return _static_left_controller.get_float("trigger")  # Default Godot OpenXR action name

## Returns trigger squeeze value on the right controller
static func get_trigger_right_value() -> float:
	if not _static_right_controller: return 0.0
	return _static_right_controller.get_float("trigger")

## Returns grip squeeze value on the left controller
static func get_grip_left_value() -> float:
	if not _static_left_controller: return 0.0
	return _static_left_controller.get_float("grip")

## Returns grip squeeze value on the right controller
static func get_grip_right_value() -> float:
	if not _static_right_controller: return 0.0
	return _static_right_controller.get_float("grip")


# =============================================================================
# DIGITAL BUTTONS (Pressed / Touched)
# =============================================================================

# --------------------- Pressed (fully pressed) ---------------------

static func get_button_left_down_x_press() -> bool:
	if not _static_left_controller: return false
	return _static_left_controller.is_button_pressed("ax_button")  # or "x_button" depending on your action map

static func get_button_left_up_y_press() -> bool:
	if not _static_left_controller: return false
	return _static_left_controller.is_button_pressed("by_button")  # or "y_button"

static func get_button_right_down_a_press() -> bool:
	if not _static_right_controller: return false
	return _static_right_controller.is_button_pressed("ax_button")  # A on right = ax_button in many maps

static func get_button_right_up_b_press() -> bool:
	if not _static_right_controller: return false
	return _static_right_controller.is_button_pressed("by_button")

static func get_button_menu_left_press() -> bool:
	if not _static_left_controller: return false
	return _static_left_controller.is_button_pressed("menu_button")

# --------------------- Touch (finger on button, not necessarily pressed) ---------------------

static func get_button_left_down_x_touch() -> bool:
	if not _static_left_controller: return false
	return _static_left_controller.is_button_pressed("ax_touch")

static func get_button_left_up_y_touch() -> bool:
	if not _static_left_controller: return false
	return _static_left_controller.is_button_pressed("by_touch")

static func get_button_right_down_a_touch() -> bool:
	if not _static_right_controller: return false
	return _static_right_controller.is_button_pressed("ax_touch")

static func get_button_right_up_b_touch() -> bool:
	if not _static_right_controller: return false
	return _static_right_controller.is_button_pressed("by_touch")



# =============================================================================
# JOYPADS / THUMBSTICKS
# =============================================================================

static func get_left_joystick_2d_value() -> Vector2:
	if not _static_left_controller:
		return Vector2.ZERO
	
	for name in ["primary", "thumbstick", "joystick", "secondary"]:
		var value = _static_left_controller.get_vector2(name)
		if value.length() > 0.01:   # small deadzone
			return value
	return Vector2.ZERO

static func get_right_joystick_2d_value() -> Vector2:
	if not _static_right_controller:
		return Vector2.ZERO
	
	for name in ["primary", "thumbstick", "joystick", "secondary"]:
		var value = _static_right_controller.get_vector2(name)
		if value.length() > 0.01:   # small deadzone
			return value
	return Vector2.ZERO

static func get_left_joystick_button_press() -> bool:
	if not _static_left_controller: return false
	for name in [ "thumbstick_click", "joystick_button", "primary_click", "secondary_click"]:
		if _static_left_controller.is_button_pressed(name):
			return true
	return false

static func get_right_joystick_button_press() -> bool:
	if not _static_right_controller: return false
	for name in [ "thumbstick_click", "joystick_button", "primary_click", "secondary_click"]:
		if _static_right_controller.is_button_pressed(name):
			return true
	return false

static func get_left_joystick_button_touch() -> bool:
	push_error("Not implemented. Ping if you know how.")
	if not _static_left_controller: return false
	for name in [ "thumbstick/touch"]:
		if _static_left_controller.is_button_pressed(name):
			return true
	return false

static func get_right_joystick_button_touch() -> bool:
	push_error("Not implemented. Ping if you know how.")
	if not _static_right_controller: return false
	for name in ["thumbstick/touch"]:
		if _static_right_controller.is_button_pressed(name):
			return true
	return false

static func get_left_trigger_touch() -> bool:
	if not _static_left_controller: return false
	for name in [ "trigger_touch"]:
		if _static_left_controller.is_button_pressed(name):
			return true
	return false

static func get_right_trigger_touch() -> bool:
	if not _static_right_controller: return false
	for name in ["trigger_touch"]:
		if _static_right_controller.is_button_pressed(name):
			return true
	return false



## Touch pas is present on some of the Quest controller and in other devices
static func get_left_touch_pad_joystick_2d() -> Vector2:
	if not _static_left_controller: return Vector2.ZERO
	for name in ["secondary"]:
		var value = _static_left_controller.get_vector2(name)
		if value.length() > 0.01:   # small deadzone
			return value
	return Vector2.ZERO

## Touch pas is present on some of the Quest controller and in other devices
static func get_right_touch_pad_joystick_2d() -> Vector2:
	if not _static_right_controller: return Vector2.ZERO
	for name in ["secondary"]:
		var value = _static_right_controller.get_vector2(name)
		if value.length() > 0.01:   # small deadzone
			return value
	return Vector2.ZERO

## Touch pas is present on some of the Quest controller and in other devices
static func get_left_touch_pad_click_or_touch() -> bool:
	if not _static_left_controller: return false
	return _static_left_controller.is_button_pressed("secondary_click") or _static_left_controller.is_button_pressed("secondary_touch")


## Touch pas is present on some of the Quest controller and in other devices
static func get_right_touch_pad_click_or_touch() -> bool:
	if not _static_right_controller: return false
	return _static_right_controller.is_button_pressed("secondary_click") or _static_right_controller.is_button_pressed("secondary_touch")






# =============================================================================
# HELPER / UTILITY METHODS
# =============================================================================

## Generic getter - useful when you use custom action names
static func get_float(hand: XRController3D, action_name: String) -> float:
	return hand.get_float(action_name) if hand else 0.0

static func get_vector2(hand: XRController3D, action_name: String) -> Vector2:
	return hand.get_vector2(action_name) if hand else Vector2.ZERO

static func is_pressed(hand: XRController3D, action_name: String) -> bool:
	return hand.is_button_pressed(action_name) if hand else false

static func is_touched(hand: XRController3D, action_name: String) -> bool:
	return hand.is_button_touched(action_name) if hand else false
