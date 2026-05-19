class_name InputNfcTextToSceneLoadAndDestroy
extends Node


@export var text_to_scene_name_dico:Dictionary[String,PackedScene]
@export var created_scene_from_name:Dictionary[String,Node] = {}
@export var use_debug_print:bool = false

func load_scene_from_code_text(text:String) -> void:
	if text in text_to_scene_name_dico:
		remove_scene_from_code_text(text)
		var scene = text_to_scene_name_dico[text]
		if scene:
			var instance = scene.instantiate()
			get_tree().current_scene.add_child(instance)
			created_scene_from_name[text] = instance
			if use_debug_print:
				print("Scene loaded for text: " + text)
		else:
			if use_debug_print:
				print("Scene not found for text: " + text)
	else:
		if use_debug_print:
			print("Text not found in dictionary: " + text)


func remove_scene_from_code_text(text:String) -> void:
	if text in created_scene_from_name:
		var node = created_scene_from_name[text]
		if node and node.is_inside_tree():
			node.queue_free()
		created_scene_from_name.erase(text)
		if use_debug_print:
			print("Scene removed for text: " + text)
