class_name InputOnOffKeyboardKeyLabelByEnum
extends InputAbstractOnOffEmit


signal on_key_changed(value:KeyLabel, is_on:bool)
signal on_key_changed_as_string(value:String, is_on:bool)

@export_group("Sleep Code")
@export var key_label_to_look_for: KeyLabel

@export_group("Ctrl Shift Alt")
@export var use_special_key_combination: bool = false
@export var required_control_key: bool = false
@export var required_alt_key: bool= false
@export var required_shift_key: bool= false

@export var use_print_debug: bool = true
@export_group("Debug")
@export var last_input_found_as_string: String
@export var last_input_found_as_key_label: KeyLabel

@export var last_input_received_raw_as_string: String
@export var last_input_received_cleaned_as_string: String

@export var is_shift_there_last:bool
@export var is_alt_there_last:bool
@export var is_control_there_last:bool

@export var dico :Dictionary[String, KeyLabel] = {
	"escape": KeyLabel.Escape,
	"quoteleft": KeyLabel.SpecialQuoteLeft,
	"1": KeyLabel.Key1,
	"2": KeyLabel.Key2,
	"3": KeyLabel.Key3,
	"4": KeyLabel.Key4,
	"5": KeyLabel.Key5,
	"6": KeyLabel.Key6,
	"7": KeyLabel.Key7,
	"8": KeyLabel.Key8,
	"9": KeyLabel.Key9,
	"0": KeyLabel.Key0,
	"minus": KeyLabel.KeyOemMinus,
	"equal": KeyLabel.KeyOemEqual,
	"bracketright": KeyLabel.KeyOemBracketRight,
	"bracketleft": KeyLabel.KeyOemBracketLeft,
	"apostrophe": KeyLabel.KeyOemApostrophe,
	"semicolon": KeyLabel.KeyOemSemicolon,
	"comma": KeyLabel.KeyOemComma,
	"period": KeyLabel.KeyOemPeriod,
	"slash": KeyLabel.KeyOemSlash,
	"ctrl": KeyLabel.KeySystemCtrl,
	"alt": KeyLabel.KeySystemAlt,
	"shift": KeyLabel.KeySystemShift,
	"windows": KeyLabel.KeySystemWindows,
	"capslock": KeyLabel.KeySystemCapsLock,
	"space": KeyLabel.Space,
	"tab": KeyLabel.Tab,
	"enter": KeyLabel.Enter,
	"backspace": KeyLabel.Backspace,
	"backslash":KeyLabel.BackSlash,
	"print":KeyLabel.Print,
	#"": KeyLabel.,
	"a": KeyLabel.KeyA,
	"b": KeyLabel.KeyB,
	"c": KeyLabel.KeyC,
	"d": KeyLabel.KeyD,
	"e": KeyLabel.KeyE,
	"f": KeyLabel.KeyF,
	"g": KeyLabel.KeyG,
	"h": KeyLabel.KeyH,
	"i": KeyLabel.KeyI,
	"j": KeyLabel.KeyJ,
	"k": KeyLabel.KeyK,
	"l": KeyLabel.KeyL,
	"m": KeyLabel.KeyM,
	"n": KeyLabel.KeyN,
	"o": KeyLabel.KeyO,
	"p": KeyLabel.KeyP,
	"q": KeyLabel.KeyQ,
	"r": KeyLabel.KeyR,
	"s": KeyLabel.KeyS,
	"t": KeyLabel.KeyT,
	"u": KeyLabel.KeyU,
	"v": KeyLabel.KeyV,
	"w": KeyLabel.KeyW,
	"x": KeyLabel.KeyX,
	"y": KeyLabel.KeyY,
	"z": KeyLabel.KeyZ,
	"f1": KeyLabel.F1,
	"f2": KeyLabel.F2,
	"f3": KeyLabel.F3,
	"f4": KeyLabel.F4,
	"f5": KeyLabel.F5,
	"f6": KeyLabel.F6,
	"f7": KeyLabel.F7,
	"f8": KeyLabel.F8,
	"f9": KeyLabel.F9,
	"f10": KeyLabel.F10,
	"f11": KeyLabel.F11,
	"f12": KeyLabel.F12,
	"pause": KeyLabel.PauseBreak,
	"up": KeyLabel.Up,
	"right": KeyLabel.Right,
	"down": KeyLabel.Down,
	"left": KeyLabel.Left,
	"pageup": KeyLabel.PageUp,
	"pagedown": KeyLabel.PageDown,
	"home": KeyLabel.Home,
	"end": KeyLabel.End,
	"insert": KeyLabel.Insert,
	"delete": KeyLabel.Delete,
	"numlock": KeyLabel.NumLock,
	"kp enter": KeyLabel.NumPadEnter,
	"kp multiply": KeyLabel.NumPadMultiply,
	"kp divide": KeyLabel.NumPadDivide,
	"kp add": KeyLabel.NumPadAdd,
	"kp subtract": KeyLabel.NumPadSubtract,
	"kp period": KeyLabel.NumPadPeriod,
	"kp 7": KeyLabel.NumPad7,
	"kp 8": KeyLabel.NumPad8,
	"kp 9": KeyLabel.NumPad9,
	"kp 4": KeyLabel.NumPad4,
	"kp 5": KeyLabel.NumPad5,
	"kp 6": KeyLabel.NumPad6,
	"kp 1": KeyLabel.NumPad1,
	"kp 2": KeyLabel.NumPad2,
	"kp 3": KeyLabel.NumPad3,
	"kp 0": KeyLabel.NumPad0,
}

func _init() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.echo:
		is_shift_there_last=false
		is_alt_there_last=false
		is_control_there_last=false
				
		var typed := event.as_text()
		var typed_lower := typed.replace("+"," ").to_lower()

		var is_shift_there:bool= typed_lower.find("shift")==0
		var is_alt_there:bool= typed_lower.find("alt")==0
		var is_control_there:bool= typed_lower.find("ctrl")==0
		
		is_shift_there_last=is_shift_there
		is_alt_there_last=is_alt_there
		is_control_there_last=is_control_there
		
		last_input_received_raw_as_string = typed
		last_input_received_cleaned_as_string = typed_lower.replace("shift","").replace("alt","").replace("ctrl","")
		
		if use_print_debug:
			print("Typed: ", typed)
		if typed.is_empty():
			return
		
		
		if  is_shift_there and not is_alt_there and not is_control_there:
			last_input_received_cleaned_as_string ="shift"
		if not is_shift_there and  is_alt_there and not is_control_there:
			last_input_received_cleaned_as_string ="alt"
		if not is_shift_there and not is_alt_there and is_control_there:			
			last_input_received_cleaned_as_string ="ctrl"
		
		last_input_received_cleaned_as_string = last_input_received_cleaned_as_string.strip_edges()
		var typed_as_key_label :KeyLabel = dico.get(last_input_received_cleaned_as_string , KeyLabel.Unknown)
		if typed_as_key_label == KeyLabel.Unknown:
			if use_print_debug:
				print("Typed key label not found in enum: ", last_input_received_cleaned_as_string)
			return
		
		if use_print_debug:
			print("Typed as key label: ", typed_as_key_label, " (", typed, ")")
		var is_on :bool= event.pressed
		on_key_changed.emit(typed_as_key_label, is_on)
		on_key_changed_as_string.emit(str(typed_as_key_label), is_on)

		if not use_special_key_combination or (
			(required_control_key ==is_control_there) and
			(required_alt_key == is_alt_there) and
			(required_shift_key == is_shift_there)
		):
			last_input_found_as_string = typed
			last_input_found_as_key_label = typed_as_key_label
			if typed_as_key_label == key_label_to_look_for:
				notify_as_changed_state(is_on)

	
		
enum KeyLabel {	
	Escape,
	SpecialQuoteLeft,

	Key1,
	Key2,
	Key3,
	Key4,
	Key5,
	Key6,
	Key7,
	Key8,
	Key9,
	Key0,

	KeyOemMinus,
	KeyOemEqual,
	KeyOemBracketRight,
	KeyOemBracketLeft,
	KeyOemApostrophe,
	KeyOemSemicolon,
	KeyOemComma,
	KeyOemPeriod,
	KeyOemSlash,

	KeySystemCtrl,
	KeySystemAlt,
	KeySystemShift,
	KeySystemWindows,
	KeySystemCapsLock,

	Space,
	Tab,
	KeyA,
	KeyB,
	KeyC,
	KeyD,
	KeyE,
	KeyF,
	KeyG,
	KeyH,
	KeyI,	
	KeyJ,
	KeyK,
	KeyL,
	KeyM,
	KeyN,
	KeyO,
	KeyP,
	KeyQ,
	KeyR,
	KeyS,
	KeyT,
	KeyU,
	KeyV,
	KeyW,
	KeyX,
	KeyY,
	KeyZ,
	F1,
	F2,
	F3,
	F4,
	F5,
	F6,	
	F7,
	F8,
	F9,	
	F10,
	F11,
	F12,

	PauseBreak,
	Print,
	Enter,
	Backspace,
	BackSlash,
	
	Up,
	Right,
	Down,
	Left,

	PageUp,
	PageDown,
	Home,
	End,
	Insert,
	Delete,
	
	NumLock,
	NumPadEnter,
	NumPadMultiply,
	NumPadDivide,
	NumPadAdd,
	NumPadSubtract,
	NumPadPeriod,
	NumPad7,
	NumPad8,
	NumPad9,
	NumPad4,
	NumPad5,
	NumPad6,
	NumPad1,
	NumPad2,
	NumPad3,
	NumPad0,
	
	
	Unknown
}
