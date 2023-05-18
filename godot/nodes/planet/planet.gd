class_name Planet
extends Node3D

@onready var orbit_tween: Tween
@onready var planet_tween: Tween

@export_group("Planet")
@export var planet_name: String
@export var planet_radius: float
@export var planet_height: float
@export var planet_tilt: float
@export_file("*.jpg") var planet_texture
@export_multiline var planet_description: String

@export_group("Orbit Path")
@export var path_radius: float
@export var path_tilt: float

@export_group("Animations")
@export var planet_ratio: float
@export var orbit_ratio: float
@export var orbit_offset: float

@export_group("Extras")
@export var planet_extra: Array[PackedScene]
@export var planet_moon: Array[PackedScene]


var center
var planet
var path_mesh : TorusMesh
var path_material : BaseMaterial3D
var solar_camera
var view


	

func _ready():
	var path = MeshInstance3D.new()
	
	# make the path mesh
	path_mesh = TorusMesh.new()
#	path_mesh.inner_radius = path_radius - 0.05
#	path_mesh.outer_radius = path_radius + 0.05
	
	# make the path material
	path_material = StandardMaterial3D.new()
	path_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	path_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	path_material.albedo_color = Color("#ffffff69")
	
	# add center node with planet inside
	center = Node3D.new()
	center.rotation_degrees.y = orbit_offset
	center.add_child(_make_planet())
	
	# add material, mesh and center node to the path node
	path_mesh.material = path_material
	path.mesh = path_mesh
	path.add_child(center)
	add_child(path)
	
	# animate center & planet
	_animate_orbit()
	
	# set orbital tilt to path 
	path.rotation_degrees.z = path_tilt
	
	SolarSettings.speed_factor_updated.connect(_animate_orbit)
	SolarSettings.planet_view_toggled.connect(_check_visibility)


func _process(_delta):
	# change path thickness according to distance of camera
	path_mesh.inner_radius = SolarSettings.object_distance * path_radius - 0.001 * SolarSettings.global_camera.z_position
	path_mesh.outer_radius = SolarSettings.object_distance * path_radius + 0.001 * SolarSettings.global_camera.z_position


func _make_planet() -> Node3D:
	var planet_container = Node3D.new()
	planet = MeshInstance3D.new()
	
	# make planet mesh
	var planet_mesh = SphereMesh.new()
	planet_mesh.radius = planet_radius
	planet_mesh.height = planet_height
	
	# make planet material
	var planet_material = StandardMaterial3D.new()
	planet_material.albedo_texture = load(planet_texture)
	
	# add planet mesh & material to mesh node
	planet_mesh.material = planet_material
	planet.mesh = planet_mesh
	
	# add extra scenes to planet
	for scene in planet_extra:
		planet.add_child(scene.instantiate())
		
	for scene in planet_moon:
		planet_container.add_child(scene.instantiate())
	
	# create node to tilt the planet axis
	var planet_axis = Node3D.new()
	planet_axis.add_child(planet)
	planet_axis.rotation_degrees.z = planet_tilt
	planet_container.add_child(planet_axis, true)
	
	# add camera
	solar_camera = load("res://nodes/camera/solarcamera.tscn").instantiate()
	planet_container.add_child(solar_camera)
	

	# add name label
	planet_container.add_child(_make_label())
	
	# set planet position on path
	planet_container.position.x = SolarSettings.object_distance * path_radius 
	
	return planet_container


func _make_label() -> Node3D:
	# place label above planet
	var container = Node3D.new()
	container.position.y = planet_height
	
	# give label name, target, radius and click event
	var label = load("res://nodes/label/solarlabel.tscn").instantiate()
	label.label_text = planet_name
	label.target_node = container
	label.object_radius = SolarSettings.object_distance * path_radius
	label.solar_label_clicked.connect(_open_planet_view)
	
	container.add_child(label)
	
	return container


func _animate_orbit():
	# PATH ANIMATION
	# tween setup: kill previous and create new one
	if orbit_tween:
		orbit_tween.kill()
	orbit_tween = create_tween().set_loops()

	# rotate center in a full circle, on loop
	orbit_tween.tween_property(
		center, 
		"rotation_degrees", 
		Vector3(0, 360, 0), 
		(orbit_ratio * SolarSettings.orbital_speed) / SolarSettings.speed_factor
	).as_relative()
	
	# PLANET ANIMATION
	# tween setup: kill previous and create new one
	if planet_tween:
		planet_tween.kill()
	planet_tween = create_tween().set_loops()
	
	# rotate planet around itself, on loop
	planet_tween.tween_property(
		planet,
		"rotation_degrees", 
		Vector3(0, 360, 0), 
		(planet_ratio * SolarSettings.rotation_speed) / SolarSettings.speed_factor
	).as_relative()


# check if planet & path are visible
func _check_visibility():
	if SolarSettings.in_planet_view == "":
		visible = true
		path_material.albedo_color.a = 105
	
	elif SolarSettings.in_planet_view != planet_name:
		visible = false

	else: 
		visible = true
		path_material.albedo_color.a = 0


# open planet view, changes camera position + view content
func _open_planet_view():
	solar_camera.to_right = planet_height * -0.5
	solar_camera.change_current()
	solar_camera.z_position = planet_height * 1.2
	solar_camera.z_min = solar_camera.z_position * 0.5
	solar_camera.z_max = solar_camera.z_position * 5
	
	
	SolarSettings.in_planet_view = planet_name
	SolarSettings.global_view.fill_view(planet_name, planet_description)
	SolarSettings.global_view.show_view(true)
