@tool
extends Node2D
class_name ObjectView

signal close_clicked

@onready var player = $Margin/VBox/VideoPanel/Ratio/Video
@onready var play_button = $Margin/VBox/VideoPanel/Ratio/Play

func _ready():
	SolarSettings.settings_view_toggled.connect(_toggle_interaction)
	SolarSettings.planet_view_toggled.connect(_on_video_stream_player_finished)
	SolarSettings.add_text_nodes([
		$Margin/VBox/HSplit/Name,
		$Margin/VBox/TextPanel/Description
	])


func _on_video_stream_player_finished():
	player.stop()
	play_button.modulate = Color(1,1,1,1)


func _on_play_pressed():
	if player.paused and player.is_playing():
		player.paused = false
		play_button.modulate = Color(0,0,0,0)

	elif not player.paused and player.is_playing():
		player.paused = true
		play_button.modulate = Color(1,1,1,1)

	else:
		player.paused = false
		player.play() 
		play_button.modulate = Color(0,0,0,0)


func _on_button_pressed():
	close_clicked.emit()
	_on_video_stream_player_finished()
	
	show_view(false)
	SolarSettings.in_planet_view = ""
	SolarSettings.global_camera.change_current()


func _toggle_interaction():
	if SolarSettings.in_settings_view:
		$Margin.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$Margin.process_mode = Node.PROCESS_MODE_INHERIT


func show_view(view_visible : bool):
	visible = view_visible


func fill_view(object_name, object_description):
	$Margin/VBox/HSplit/Name.text = object_name
	$Margin/VBox/TextPanel/Description.text = object_description
	
	var video_name = object_name.to_lower()
	player.stream = load("res://videos/" + video_name + ".ogv")


func full_video():
	$Margin/VBox/TextPanel.visible = false
	player.expand = false
