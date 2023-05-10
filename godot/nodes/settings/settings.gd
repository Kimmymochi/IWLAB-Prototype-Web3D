extends Node

@onready var open_settings = $VBoxContainer/Margin/HBox/Button
@onready var background = $Background
@onready var settings_box = $VBoxContainer/SettingsBox



func _on_button_toggled(button_pressed):
	if(button_pressed):
		open_settings.icon = load("res://icons/close.svg")
		background.visible = true
		settings_box.visible = true
	else:
		open_settings.icon = load("res://icons/settings.svg")
		background.visible = false
		settings_box.visible = false
		
	
