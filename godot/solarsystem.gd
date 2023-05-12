@tool
extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	SolarSettings.global_camera = $Camera
	SolarSettings.global_view = $ObjectView
	$HSlider.value = SolarSettings.speed_factor
	
	SolarSettings.planet_view_toggled.connect(_h_slider_visibility)


# Slider changes animation speeds
func _on_h_slider_value_changed(value):
	SolarSettings.speed_factor = value


func _h_slider_visibility():
	$HSlider.visible = SolarSettings.in_planet_view == ""
