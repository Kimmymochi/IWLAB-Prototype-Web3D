@tool
extends Node

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


var global_camera : SolarCamera
var global_view : ObjectView

signal speed_factor_updated
signal planet_view_toggled
signal settings_view_toggled
