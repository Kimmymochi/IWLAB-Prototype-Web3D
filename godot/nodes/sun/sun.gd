@tool
class_name Sun
extends Node3D
var sun_tween : Tween




func _ready():
	_sun_animate()
	SolarSettings.speed_factor_updated.connect(_sun_animate)


func _sun_animate():
	if sun_tween:
		sun_tween.kill()
	sun_tween = create_tween().set_loops()
#
	sun_tween.tween_property(
		$Sun, 
		"rotation_degrees", 
		Vector3(0, 360, 0), 
		49.4 / SolarSettings.speed_factor
	).from_current()
