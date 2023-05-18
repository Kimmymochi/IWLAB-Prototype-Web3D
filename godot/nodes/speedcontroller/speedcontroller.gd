extends Control

@onready var speed = $Margin/VBox/Text
@onready var speed_slider = $Margin/VBox/HBoxContainer/Slider
@onready var regular_button = preload("res://icons/rocket.svg")
@onready var paused_button = preload("res://icons/pause.svg")


# Called when the node enters the scene tree for the first time.
func _ready():
	
	speed_slider.value = SolarSettings.speed_factor
	speed.text = "[center]"  + time_calculator(SolarSettings.orbital_speed) + "[/center]"
	SolarSettings.add_text_nodes([speed])
	SolarSettings.planet_view_toggled.connect(_slider_visibility)

# Slider changes animation speeds
func _on_slider_value_changed(value):
	SolarSettings.speed_factor = value
	
	if(is_inf(SolarSettings.orbital_speed / value)):
		speed_slider.add_theme_icon_override("grabber", paused_button)
		speed_slider.add_theme_icon_override("grabber_highlight", paused_button)
	else:
		speed_slider.add_theme_icon_override("grabber", regular_button )
		speed_slider.add_theme_icon_override("grabber_highlight", regular_button)
		
	speed.text = "[center]" + time_calculator(SolarSettings.orbital_speed / value) + "[/center]"


func _slider_visibility():
	visible = SolarSettings.in_planet_view == ""

func time_calculator(value):
	
	if(is_inf(value)):	
		return "Tijd op Pauze"
		
	
	elif(value >= 3600):
		return "1 jaar = " + str(value / 3600 ).pad_decimals(0) + " uur"
	
	elif(value >= 60):
		return "1 jaar = " + str(value / 60 ).pad_decimals(0) + " min."
		
	else:
		return "1 jaar = " + str(value).pad_decimals(0) + " sec."
