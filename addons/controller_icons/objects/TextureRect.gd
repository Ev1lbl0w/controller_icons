@tool
extends TextureRect
class_name ControllerTextureRect

@export var path : String = "":
	set(_path):
		path = _path
		if is_inside_tree():
			texture = ControllerIcons.parse_path(path)
		
@export_enum("Both", "Keyboard/Mouse", "Controller") var show_only : int = 0:
	set(_show_only):
		show_only = _show_only
		_on_input_type_changed(ControllerIcons._last_input_type)
	
@export var max_width : int = 40:
	set(_max_width):
		max_width = _max_width
		if is_inside_tree():
			if max_width < 0:
				ignore_texture_size = false
			else:
				ignore_texture_size = true
				custom_minimum_size.x = max_width
				if texture:
					custom_minimum_size.y = texture.get_height() * max_width / texture.get_width()
				else:
					custom_minimum_size.y = custom_minimum_size.x

func _ready():
	ControllerIcons.input_type_changed.connect(_on_input_type_changed)
	self.path = path
	self.max_width = max_width

func _on_input_type_changed(input_type):
	if show_only == 0 or \
		(show_only == 1 and input_type == ControllerIcons.InputType.KEYBOARD_MOUSE) or \
		(show_only == 2 and input_type == ControllerIcons.InputType.CONTROLLER):
		visible = true
		self.path = path
	else:
		visible = false
