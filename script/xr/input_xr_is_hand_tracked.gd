
class_name InputXrIsHandTracked
extends Node

signal on_left_hand_tracked(is_tracked: bool)
signal on_right_hand_tracked(is_tracked: bool)
signal on_left_hand_source_changed(source: XRHandTracker.HandTrackingSource)
signal on_right_hand_source_changed(source: XRHandTracker.HandTrackingSource)

@export var hand_left_tracker_name: String = "/user/hand_tracker/left"
@export var hand_right_tracker_name: String = "/user/hand_tracker/right"

var left_tracker: XRHandTracker
var right_tracker: XRHandTracker
@export_group("Debug")
@export var _last_left_tracked := false
@export var _last_right_tracked := false
@export var _last_left_source := XRHandTracker.HAND_TRACKING_SOURCE_NOT_TRACKED
@export var _last_right_source := XRHandTracker.HAND_TRACKING_SOURCE_NOT_TRACKED

func _ready() -> void:
	XRServer.tracker_added.connect(_on_tracker_added)
	XRServer.tracker_updated.connect(_on_tracker_updated)
	
	# Try to get them immediately in case they are already available
	_acquire_trackers()


func _acquire_trackers() -> void:
	left_tracker = XRServer.get_tracker(hand_left_tracker_name) as XRHandTracker
	right_tracker = XRServer.get_tracker(hand_right_tracker_name) as XRHandTracker


func _on_tracker_added(tracker_name: String, type: int) -> void:
	if tracker_name == hand_left_tracker_name or tracker_name == hand_right_tracker_name:
		_acquire_trackers()


func _on_tracker_updated(tracker_name: String, type: int) -> void:
	# Optional: you can react to updates if needed
	pass


func _process(_delta: float) -> void:
	_check_hand(left_tracker, true)
	_check_hand(right_tracker, false)


func _check_hand(tracker: XRHandTracker, is_left: bool) -> void:
	if not tracker:
		return
	
	var currently_tracked := tracker.has_tracking_data
	var current_source := tracker.hand_tracking_source
	
	if is_left:
		if currently_tracked != _last_left_tracked:
			_last_left_tracked = currently_tracked
			on_left_hand_tracked.emit(currently_tracked)
		
		if current_source != _last_left_source:
			_last_left_source = current_source
			on_left_hand_source_changed.emit(current_source)
	else:
		if currently_tracked != _last_right_tracked:
			_last_right_tracked = currently_tracked
			on_right_hand_tracked.emit(currently_tracked)
		
		if current_source != _last_right_source:
			_last_right_source = current_source
			on_right_hand_source_changed.emit(current_source)


func is_left_hand_tracked() -> bool:
	return _last_left_tracked

func is_right_hand_tracked() -> bool:
	return _last_right_tracked
