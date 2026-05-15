#extends Node3D
#class_name InputXrFingerTip
#
#enum HandType { LEFT, RIGHT }
#
#@export var what_to_move: Node3D
#@export var hand_type: HandType = HandType.LEFT
#@export var joint_to_follow: XRHandTracker.HandJoint = XRHandTracker.HAND_JOINT_INDEX_FINGER_TIP
#
### Try these tracker names in order until one is found
#@export var tracker_names: Array[String] = [
	#"/user/hand_tracker/left",
	#"/user/hand/left",
	#"left_hand"
#]
#
#var _tracker: XRHandTracker = null
#
#func _ready() -> void:
	#_tracker = _find_tracker()
	#if not _tracker:
		#push_warning("No hand tracker found for %s hand" % ("Left" if hand_type == HandType.LEFT else "Right"))
#
#
#func _find_tracker() -> XRHandTracker:
	#var names_to_try: Array[String] = tracker_names
	#
	## Auto-generate common names if user didn't customize
	#if names_to_try.size() == 0 or names_to_try == ["/user/hand_tracker/left", "/user/hand/left", "left_hand"]:
		#names_to_try = _get_default_tracker_names()
	#
	#for name in names_to_try:
		#var tracker = XRServer.get_tracker(name) as XRHandTracker
		#if tracker:
			#print("Found hand tracker: ", name)
			#return tracker
	#
	#return null
#
#
#func _get_default_tracker_names() -> Array[String]:
	#if hand_type == HandType.LEFT:
		#return [
			#"/user/hand_tracker/left",
			#"/user/hand/left",
			#"left_hand"
		#]
	#else:
		#return [
			#"/user/hand_tracker/right",
			#"/user/hand/right",
			#"right_hand"
		#]
#
#
#func _process(_delta: float) -> void:
	#if not _tracker or not what_to_move:
		#return
	#
	#if not _tracker.has_tracking_data:
		#return
	#
	#var joint_transform: Transform3D = _tracker.get_hand_joint_transform(joint_to_follow)
	#
	## Invalid transform check
	#if joint_transform == Transform3D.IDENTITY or joint_transform.origin.is_equal_approx(Vector3.ZERO):
		#return
	#
	#what_to_move.global_transform = joint_transform
