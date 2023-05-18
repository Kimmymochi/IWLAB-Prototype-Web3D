extends Node

var fonts = {
	"standard": {
		"regular": preload("res://fonts/CPCompanyTTRegular.ttf"),
		"bold": preload("res://fonts/CPCompanyTTBold.ttf")
		},
	"dyslexic": 
		{
		"regular": preload("res://fonts/OpenDyslexic-Regular.otf"),
		"bold": preload("res://fonts/OpenDyslexic-Bold.otf")
		}
}
var texts = []

# Animation speeds based on Earth
# 1 year  = 120 sec. -> 1 day = 120 / 365
var orbital_speed : float = 120
var rotation_speed : float = orbital_speed / 365
var object_distance = 60


# set speed for all animations
var speed_factor : float = 1:
	get:
		return speed_factor if in_planet_view.is_empty() else 0.01
		
	set(value):
		speed_factor = value
		speed_factor_updated.emit()

# check which planet is in view
var in_planet_view : String = "":
	set(value):
		in_planet_view = value
		planet_view_toggled.emit()
		speed_factor_updated.emit()

# check if settings view is open
var in_settings_view : bool = false:
	set(value):
		in_settings_view = value
		settings_view_toggled.emit()

var current_font : String = "standard":
	set(value):
		current_font = value
		font_toggled.emit()
		font_changer()

func add_text_nodes(text_nodes):
	texts += text_nodes
	font_changer()
	
func font_changer():
	for text in texts:
		if is_instance_valid(text):
			text.add_theme_font_override("font", SolarSettings.fonts[SolarSettings.current_font].bold)
			text.add_theme_font_override("normal_font", SolarSettings.fonts[SolarSettings.current_font].regular) 
			text.add_theme_font_override("bold_font", SolarSettings.fonts[SolarSettings.current_font].bold) 


var global_camera : SolarCamera
var global_view : ObjectView

signal speed_factor_updated
signal planet_view_toggled
signal settings_view_toggled
signal font_toggled
