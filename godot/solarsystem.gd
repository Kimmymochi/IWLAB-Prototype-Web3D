extends Node3D

#@onready var planets = $WorldSphere/Sun/Planet/PlanetAnimate

# Called when the node enters the scene tree for the first time.
func _ready():
	SolarSettings.global_camera = $Camera



#func _on_Button_button_down():
#
#	pass # Replace with function body.
#
#
#func _on_Button_toggled(button_pressed):
#	if button_pressed:
#		planets.play("spin")
#		#$Earth.transform = rotateAround($Sun.transform, $Earth.transform)
#
#	else:
#		planets.stop(false)
#
#	pass # Replace with function body.


func _on_h_slider_value_changed(value):
	SolarSettings.speed_factor = value
	pass # Replace with function body.
