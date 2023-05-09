extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	SolarSettings.speed_factor_updated.connect(_venus_speed)
	print($AnimationPlayer.current_animation_length)
	


func _venus_speed():
	$AnimationPlayer.speed_scale = SolarSettings.speed_factor
