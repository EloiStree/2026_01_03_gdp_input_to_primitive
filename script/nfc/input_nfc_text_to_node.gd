class_name InputNfcTextToNodeSpawn
extends Node



signal on_node_spawned(new_node:Node)
signal on_node_spawned_with_code_name(new_node:Node, invokation_name:String)
signal on_node_code_found(text_found:String)
signal on_node_code_not_found(text_not_found:String)

@export var text_to_node_dico:Dictionary[String,Node]
@export var where_to_create_node:Node3D

func try_spawn_node_from_text(text:String) -> void:
	if text in text_to_node_dico:
		var node_to_spawn = text_to_node_dico[text]
		if node_to_spawn == null:
			on_node_code_not_found.emit(text)
			return
		if node_to_spawn is Node3D:
			var node3d_to_spawn = node_to_spawn as Node3D
			var new_node3d = node3d_to_spawn.duplicate() as Node3D
			where_to_create_node.add_child(new_node3d)
			on_node_code_found.emit(text)
			on_node_spawned.emit(new_node3d)
			on_node_spawned_with_code_name.emit(new_node3d, text)
		else:
			var new_node = node_to_spawn.duplicate()
			where_to_create_node.add_child(new_node)
			on_node_code_found.emit(text)
			on_node_spawned.emit(new_node)
			on_node_spawned_with_code_name.emit(new_node, text)
	else:
		on_node_code_not_found.emit(text)
		
	
