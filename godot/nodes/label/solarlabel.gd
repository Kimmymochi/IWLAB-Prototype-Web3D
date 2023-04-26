extends Node2D

@export var label_text: String
@export var target_node : Node3D



signal solar_label_clicked

# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/Button.text = label_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_viewport().get_camera_3d().unproject_position(target_node.global_position)
	var in_view = not get_viewport().get_camera_3d().is_position_behind(target_node.global_position)
	visible = in_view and SolarSettings.in_planet_view.is_empty() 

func _on_button_pressed():
	solar_label_clicked.emit()