extends Node3D


#export var r=1
#var theta=0
#var dtheta=2*PI/250

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func _process(_delta):
#	$kjoeb.transform = rotateAround($Camera.transform, $kjoeb.transform)
#	pass

#func rotateAround(var a, var b):
#	theta += dtheta
#	b.origin.x = a.origin.x + r*cos(theta)
#	b.origin.y = a.origin.y + r*sin(theta)
#	b.origin.z = a.origin.z
#
func _on_Button_button_down():
	
	pass # Replace with function body.


func _on_Button_toggled(button_pressed):
	if button_pressed:
		$Sun/Planet/PlanetAnimate.play("spin")
		#$Earth.transform = rotateAround($Sun.transform, $Earth.transform)

	else:
		$Sun/Planet/PlanetAnimate.stop(false)
	
	pass # Replace with function body.
