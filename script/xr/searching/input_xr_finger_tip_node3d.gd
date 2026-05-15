extends XRNode3D
class_name InputXrFingerTipNode3D

enum HandType { LEFT, RIGHT }

@export var hand_type: HandType = HandType.LEFT
@export var joint_to_follow: XRHandTracker.HandJoint = XRHandTracker.HAND_JOINT_INDEX_FINGER_TIP

# Optional: If you want to apply an offset (local to the fingertip)
@export var position_offset: Vector3 = Vector3.ZERO
@export var rotation_offset: Vector3 = Vector3.ZERO  # In degrees

var _tracker: XRHandTracker = null


func _ready() -> void:
	# Automatically set the correct tracker based on hand type
	tracker = "/user/hand_tracker/left" if hand_type == HandType.LEFT else "/user/hand_tracker/right"
	
	# Try fallback names if the main one doesn't exist
	if XRServer.get_tracker(tracker) == null:
		tracker = "/user/hand/left" if hand_type == HandType.LEFT else "/user/hand/right"
	
	_tracker = XRServer.get_tracker(tracker) as XRHandTracker
	
	if not _tracker:
		push_warning("Hand tracker not found for " + tracker)


func _process(_delta: float) -> void:
	if not _tracker or not _tracker.has_tracking_data:
		return
	
	var joint_transform: Transform3D = _tracker.get_hand_joint_transform(joint_to_follow)
	
	if joint_transform == Transform3D.IDENTITY:
		return
	
	# Apply the joint transform
	global_transform = joint_transform
	
	# Apply optional offset
	if not position_offset.is_zero_approx():
		global_position += global_basis * position_offset
	
	if not rotation_offset.is_zero_approx():
		rotate_object_local(Vector3.RIGHT,   deg_to_rad(rotation_offset.x))
		rotate_object_local(Vector3.UP,      deg_to_rad(rotation_offset.y))
		rotate_object_local(Vector3.BACK,    deg_to_rad(rotation_offset.z))
