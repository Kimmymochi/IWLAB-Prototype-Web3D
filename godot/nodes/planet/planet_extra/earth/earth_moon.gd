extends Node3D
class_name Moon


var path_speed = 0.0748
var path_radius = 0.00257 * SolarSettings.object_distance + 5.222
var path_tilt = 5.1
var moon_speed = 27.4
var moon_tilt = 6.7
var moon_height = 1.422
var solar_camera

@export var moon_name : String
@export_multiline var moon_description : String

@onready var solar_label = $Path/Center/Container/MoonLabel/SolarLabel
@onready var orbit_tween: Tween
@onready var moon_tween: Tween

func _ready():
	$Path.rotation_degrees.z = path_tilt
	$Path/Center/Container/Axis.rotation_degrees.z = moon_tilt

	$Path/Center/Container.position.x = path_radius
	$Path/Center/Container/MoonLabel.position.y = moon_height
	
	solar_camera = load("res://nodes/camera/solarcamera.tscn").instantiate()
	$Path/Center/Container.add_child(solar_camera)
	
	_animate_moon()
	SolarSettings.speed_factor_updated.connect(_animate_moon)
	SolarSettings.planet_view_toggled.connect(_check_visibility)
	solar_label.solar_label_clicked.connect(_open_moon_view)



func _animate_moon():
	# PATH ANIMATION
	# tween setup: kill previous and create new one
	if orbit_tween:
		orbit_tween.kill()
	orbit_tween = create_tween().set_loops()

	# rotate center in a full circle, on loop
	orbit_tween.tween_property(
		$Path/Center, 
		"rotation_degrees", 
		Vector3(0, 360, 0), 
		(path_speed * SolarSettings.orbital_speed) / SolarSettings.speed_factor
	).as_relative()
	
	# PLANET ANIMATION
	# tween setup: kill previous and create new one
	if moon_tween:
		moon_tween.kill()
	moon_tween = create_tween().set_loops()
	
	# rotate planet around itself, on loop
	moon_tween.tween_property(
		$Path/Center/Container/Axis/Moon,
		"rotation_degrees", 
		Vector3(0, 360, 0), 
		(moon_speed * SolarSettings.rotation_speed) / SolarSettings.speed_factor
	).as_relative()



# open planet view, changes camera position + view content
func _open_moon_view():
	solar_camera.to_right = moon_height * -0.5
	solar_camera.change_current()
	solar_camera.z_position = moon_height * 1.2
	solar_camera.z_min = solar_camera.z_position * 0.5
	solar_camera.z_max = solar_camera.z_position * 5

	SolarSettings.in_planet_view = moon_name
	SolarSettings.global_view.fill_view(moon_name, moon_description)
	SolarSettings.global_view.show_view(true)
	

# check if planet & path are visible
func _check_visibility():
	var parent = get_node('../../../..')
	var parent_label = get_node('../').get_child(3).get_child(0)
	
	match SolarSettings.in_planet_view:
		"":
			visible = true
			solar_label.visible = false
			parent_label.inside_view_label = false
			parent_label.visible = true
			
		"Aarde":
			visible = true
			solar_label.visible = true
			parent_label.inside_view_label = false
			parent_label.visible = false
		"Maan":
			visible = true
			parent.visible = true
			solar_label.visible = false
			parent_label.inside_view_label = true
			parent_label.visible = true
			
		_: 
			visible = false
			parent.visible = false
			solar_label.visible = false
			parent_label.inside_view_label = false
			parent_label.visible = false
