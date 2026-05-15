class_name InputOnOffKeyboardKeyLabelByString
extends InputAbstractOnOffEmit


signal on_event_key_full_text(text:String, is_on:bool)
signal on_event_key_word(text:String, is_on:bool)

@export_group("Unfinish Code")
@export var key_label_to_look_for: String = "Shift+F1"
@export var use_print_debug: bool = true
@export var last_input_found: String 
@export var last_input_word_found: String 

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		var typed := event.as_text()
		var is_on: bool = event.is_pressed()
		
		var str: PackedStringArray = typed.to_lower().replace("+", " ").split(" ")
		var word: String = "" if str.size() == 0 else str[str.size() - 1]
		
		last_input_word_found = word
		
		on_event_key_word.emit(word, is_on)
		on_event_key_full_text.emit(typed, is_on)
		
		if typed == key_label_to_look_for:
			last_input_found = " ".join([typed, " ", str(event.is_pressed())])
			notify_as_changed_state(event.pressed)
			
		if use_print_debug:
			print("Typed: ", typed, " On:", is_on)

	
	
