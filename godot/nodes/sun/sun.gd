@tool
class_name Sun
extends Node3D

@onready var sun_tween: Tween = create_tween()

func _ready():
	_sun_animate()



func _sun_animate():
	# rotate sun in a full circle, on loop
	sun_tween.tween_property(
		$Sun, 
		"rotation_degrees", 
		Vector3(0, 360, 0), 
		16.8
	).from_current()
	sun_tween.set_loops()
