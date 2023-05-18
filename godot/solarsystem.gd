extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	SolarSettings.global_camera = $Camera
	SolarSettings.global_view = $ObjectView
