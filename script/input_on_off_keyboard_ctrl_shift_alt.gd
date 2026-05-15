class_name InputOnOffKeyboardCtrlShiftAlt
extends InputAbstractOnOffEmit

signal on_controle_changed(is_on:bool)
signal on_shift_changed(is_on:bool)
signal on_alt_changed(is_on:bool)

@export var required_control_key: bool = false
@export var required_alt_key: bool= false
@export var required_shift_key: bool= false

@export var use_print_debug: bool = true

@export_group("Debug")
@export var is_shift_there_last:bool
@export var is_alt_there_last:bool
@export var is_controle_there_last:bool

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		is_shift_there_last=false
		is_alt_there_last=false
		is_controle_there_last=false
				
		var typed := event.as_text()
		var typed_lower := typed.replace("+"," ").to_lower()

		var last_word := typed_lower.split(" ")[-1]
		
		print( typed, event.is_pressed())
		
		if use_print_debug:
			print(typed_lower)
		
		var is_shift_there:bool= typed_lower.contains("shift")
		var is_alt_there:bool= typed_lower.contains("alt")
		var is_controle_there:bool= typed_lower.contains("ctrl")
		
		if last_word=="shift":
			is_shift_there = event.is_pressed()
		if last_word=="alt":
			is_alt_there = event.is_pressed()
		if last_word=="ctrl":
			is_controle_there = event.is_pressed()
		
		var shift_changed :bool= is_shift_there !=is_shift_there_last
		var alt_changed :bool= is_alt_there !=is_alt_there_last
		var controle_changed :bool= is_controle_there !=is_controle_there_last

		
				
		is_shift_there_last=is_shift_there
		is_alt_there_last=is_alt_there
		is_controle_there_last=is_controle_there
		
		if shift_changed :
			on_shift_changed.emit(is_shift_there)	
		if alt_changed :
			on_alt_changed.emit(is_alt_there)	
		if controle_changed :
			on_controle_changed.emit(is_controle_there)		
			
		if use_print_debug:
			print("Ctrl/Alt/Shift - Ctrl: %s, Alt: %s, Shift: %s" % [is_controle_there, is_alt_there, is_shift_there])
			
		var is_on:bool = (required_shift_key == is_shift_there) and (required_alt_key == is_alt_there) and (required_control_key == is_controle_there )
		notify_as_changed_state(is_on)
			
