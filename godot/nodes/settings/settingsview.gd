extends Node

@onready var open_settings = $VBoxContainer/Margin/HBox/Button
@onready var background = $Background
@onready var settings_box = $VBoxContainer/SettingsBox
@onready var fullscreen = $"VBoxContainer/SettingsBox/VBox/Panel/VBoxContainer/FullScreen"


func _on_button_toggled(button_pressed):
	if(button_pressed):
		SolarSettings.in_settings_view = true
		open_settings.icon = load("res://icons/close.svg")
		background.visible = true
		settings_box.visible = true
	else:
		SolarSettings.in_settings_view = false
		open_settings.icon = load("res://icons/settings.svg")
		background.visible = false
		settings_box.visible = false


func _on_full_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
