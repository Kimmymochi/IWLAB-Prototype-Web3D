extends Node3D


var path_speed = SolarSettings.orbital_speed * 27
var path_radius = 0.08 * SolarSettings.object_distance
var path_tilt = 5.1
var moon_speed = 27.4
var moon_tilt = 6.7

@export var target_node : Node3D


@onready var target = target_node.get_node("@@22/@@21/@@20")


	
#	$Path.mesh.inner_radius = path_radius - 0.05
#	$Path.mesh.outer_radius = path_radius + 0.05
#	$Path.rotation_degrees.z = path_tilt
	
#	$Path/Center/Container/Axis.rotation_degrees.z = moon_tilt
	
#	$Path/Center/Container.position.x = SolarSettings.object_distance * path_radius
	

#	_animate_moon()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	var distance = target_node.global_position.distance_to(get_viewport().get_camera_3d().global_position) - (path_radius * 8)
#	global_position = target_node.get_children()[1].position



##	SolarSettings.speed_factor_updated.connect(_animate_orbit)

#func _animate_moon():


## open planet view, changes camera position + view content
#func _open_planet_view():
#	solar_camera.change_current()
#	solar_camera.z_position = planet_height * 1.2
#	solar_camera.z_min = solar_camera.z_position * 0.5
#	solar_camera.z_max = solar_camera.z_position * 5
#
#	SolarSettings.in_planet_view = planet_name
#	SolarSettings.global_view.fill_view(planet_name, planet_description)
#	SolarSettings.global_view.show_view(true)
