extends Node3D

@export var planet_id: int


#@export var planet_material : Texture : set = _set_texture

#@onready var texture := $PlanetMesh

#@onready var planet_material = load("res://Textures/material" + str(planet_id) + ".jpg")


var planet_name: String
var planet_radius : float
var planet_height: float

var planet_data = [
	["Zon", 54.65, 109.3],
	["Mercurius", 0.1915, 0.383],
	["Venus", 0.4749, 0.9498],
	["Aarde", 0.5, 0.997],
	["Mars", 0.2661, 0.528],
	["Jupiter", 5.485, 10.176],
	["Saturnus", 4.572, 8.24],
	["Uranus", 1.991, 3.98],
	["Neptunus", 1.933, 3.86]
	]
# Called when the node enters the scene tree for the first time.

func _ready():
	_setPlanet()
	pass # Replace with function body.

func _setPlanet():
	planet_name = planet_data[planet_id][0]
	planet_radius = planet_data[planet_id][1]
	$PlanetMesh.radius
	planet_height = planet_data[planet_id][2]
	
	
	print(planet_name)
	print(planet_radius)
	print(planet_height)
	

#func _set_texture(value : Texture) -> void:
#	planet_material = value
#	if texture: texture.texture = planet_material
#	$PlanetMesh.get_active_material(0).set("albedo_texture", planet_material)
