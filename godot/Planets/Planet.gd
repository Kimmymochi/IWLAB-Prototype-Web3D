@tool
class_name Planet
extends Node3D

@onready var orbit_tween: Tween = create_tween()
@onready var planet_tween: Tween = create_tween()


@export_group("Planet")
@export var planet_name: String
@export var planet_radius: float
@export var planet_height: float
@export_file("*.jpg") var planet_texture
@export var planet_extra: Array[PackedScene]


@export_group("Planet Animation")
@export var planet_speed: float
enum Direction {RIGHT=360, LEFT=-360}
@export var planet_direction: Direction


@export_group("Orbit")
@export var path_radius: float


@export_group("Orbit Animation")
@export var orbit_time: float
@export var orbit_offset: float


func _ready():
	var path = MeshInstance3D.new()
	
	# make the path mesh
	var path_mesh = TorusMesh.new()
	path_mesh.inner_radius = path_radius - 0.05
	path_mesh.outer_radius = path_radius + 0.05
	path_mesh.flip_faces = true
	
	# make the path material
	var path_material = StandardMaterial3D.new()
	path_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	path_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	path_material.albedo_color = Color("#ffffff69")
	
	# add center node with planet inside
	var center = Node3D.new()
	center.add_child(_make_planet())
	
	# add material, mesh and center node to the path node
	path_mesh.material = path_material
	path.mesh = path_mesh
	path.add_child(center)
	add_child(path)
	
	# animate center & planet
	_animate_orbit(center)

func _make_planet() -> Node3D:
	var sphere = MeshInstance3D.new()
	
	# make sphere mesh
	var sphere_mesh = SphereMesh.new()
	sphere_mesh.radius = planet_radius
	sphere_mesh.height = planet_height
	
	# make sphere maetrial
	var sphere_material = StandardMaterial3D.new()
	sphere_material.albedo_texture = load(planet_texture)
	
	# add sphere mesh & material to mesh node
	sphere_mesh.material = sphere_material
	sphere.mesh = sphere_mesh
	
	# add extra scenes to sphere
	for scene in planet_extra:
		sphere.add_child(scene.instantiate())
	
	# set sphere position
	sphere.position.x = path_radius
	
	return sphere

func _animate_orbit(center:Node3D):
	var planet = center.get_child(0)	
	
	# set rotation degree of center
	center.rotation_degrees.y = orbit_offset
	
	# rotate center in a full circle, on loop
	orbit_tween.tween_property(
		center, 
		"rotation_degrees", 
		Vector3(0, 360 + orbit_offset, 0), 
		orbit_time
	).from_current()
	orbit_tween.set_loops()


	planet_tween.tween_property(
		planet,
		"rotation_degrees", 
		Vector3(0, planet_direction, 0), 
		planet_speed
	).from_current()
	planet_tween.set_loops()
	
	

#
