@tool
class_name Planet
extends Node3D

@onready var tween: Tween = create_tween()

@export_group("Planet")
@export var planet_name: String
@export var planet_radius: float
@export var planet_height: float
@export_file("*.jpg") var planet_texture

@export var planet_extra: Array[PackedScene]

@export_group("Path")
@export var path_radius: float

@export_group("Orbit Animation")
@export var orbit_time: float
@export var orbit_offset: float


func _ready():
	var path = MeshInstance3D.new()
	var path_mesh = TorusMesh.new()
	var path_material = StandardMaterial3D.new()
	var center = Node3D.new()
	
	path_mesh.inner_radius = path_radius - 0.05
	path_mesh.outer_radius = path_radius + 0.05
	path_mesh.flip_faces = true
	
	path_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	path_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	path_material.albedo_color = Color("#ffffff69")
	
	center.add_child(_make_planet())
	
	path_mesh.material = path_material
	path.mesh = path_mesh
	path.add_child(center)
	
	add_child(path)
	
	_animate_planet(center)


func _make_planet() -> Node3D:
	var sphere = MeshInstance3D.new()
	var sphere_mesh = SphereMesh.new()
	var sphere_material = StandardMaterial3D.new()
	
	sphere_mesh.radius = planet_radius
	sphere_mesh.height = planet_height
	
	sphere_material.albedo_texture = load(planet_texture)
	sphere_mesh.material = sphere_material
	sphere.mesh = sphere_mesh
	
	for scene in planet_extra:
		sphere.add_child(scene.instantiate())
	
	sphere.position.x = path_radius
	
	return sphere

func _animate_planet(center:Node3D):
	center.rotation_degrees.y = orbit_offset
	
	tween.tween_property(
		center, 
		"rotation_degrees", 
		Vector3(0, 360 + orbit_offset, 0), 
		orbit_time
	).from_current()
	tween.set_loops()


#var planet_data = [
#	["Zon", 54.65, 109.3],
#	["Mercurius", 0.1915, 0.383],
#	["Venus", 0.4749, 0.9498],
#	["Aarde", 0.5, 0.997],
#	["Mars", 0.2661, 0.528],
#	["Jupiter", 5.485, 10.176],
#	["Saturnus", 4.572, 8.24],
#	["Uranus", 1.991, 3.98],
#	["Neptunus", 1.933, 3.86]
#	]
