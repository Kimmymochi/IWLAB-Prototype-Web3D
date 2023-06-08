extends Node3D

var atmosphere_speed = 4.07

# Called when the node enters the scene tree for the first time.
func _ready():
	SolarSettings.speed_factor_updated.connect(_venus_speed)

func _venus_speed():
		$AnimationPlayer.speed_scale = (atmosphere_speed * SolarSettings.rotation_speed) * SolarSettings.speed_factor
