class_name InputNfcTextToText
extends Node

signal on_text_value_found(text:String)
signal on_text_key_value_found(code:String, text:String)
signal on_text_key_not_found(code:String)

@export var text_to_scene_name_dico:Dictionary[String,String]

func try_to_emit_store_text_from_key(code:String) -> void:
	if text_to_scene_name_dico.has(code):
		var text = text_to_scene_name_dico[code]
		on_text_key_value_found.emit(code, text)
		on_text_value_found.emit(text)
	else:
		on_text_key_not_found.emit(code)
