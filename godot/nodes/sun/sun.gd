class_name Sun
extends Node3D
var sun_tween : Tween

@export var sun_name : String

@export_multiline var sun_description : String
@export var sun_id : String

var sun_tilt = 7.25
var sun_speed = 24.7


func _ready():
	$Sun.rotation_degrees.z = sun_tilt
	_sun_animate()
	SolarSettings.speed_factor_updated.connect(_sun_animate)
	$SunLabel/SolarLabel.solar_label_clicked.connect(_open_sun_view)


func _sun_animate():
	# tween setup: kill previous and create new one
	if sun_tween:
		sun_tween.kill()
	sun_tween = create_tween().set_loops()

	# rotate sun around itself in full circle
	sun_tween.tween_property(
		$Sun, 
		"rotation_degrees", 
		Vector3(0, 360, 0), 
		(sun_speed * SolarSettings.rotation_speed) / SolarSettings.speed_factor
	).as_relative()


# open sun view, changes camera position + view content
func _open_sun_view():
	$SolarCamera.to_right =  $Sun.mesh.height * -0.3
	$SolarCamera.change_current()
	$SolarCamera.z_position = $Sun.mesh.height * 1.2
	$SolarCamera.z_min = $SolarCamera.z_position * 0.5
	$SolarCamera.z_max = $SolarCamera.z_position * 5
	
	SolarSettings.in_planet_view = sun_name
	SolarSettings.global_view.fill_view(sun_name, sun_description, sun_id)
	SolarSettings.global_view.show_view(true)
