class_name InputNfcTextToVariable
extends Node

signal on_untyped_variable_found(untyped_variable)
signal on_untyped_variable_key_value_found(code:String, untyped_variable)
signal on_untyped_variable_key_not_found(code:String)

@export var text_to_scene_name_dico:Dictionary[String, Variant]

func try_to_emit_store_variable_from_key(code:String) -> void:
	if text_to_scene_name_dico.has(code):
		var text = text_to_scene_name_dico[code]
		on_untyped_variable_key_value_found.emit(code, text)
		on_untyped_variable_found.emit(text)
	else:
		on_untyped_variable_key_not_found.emit(code)
