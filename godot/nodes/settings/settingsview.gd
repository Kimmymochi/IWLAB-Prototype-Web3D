extends Node

@onready var open_settings = $VBoxContainer/Margin/HBox/Button
@onready var background = $Background
@onready var settings_box = $VBoxContainer/SettingsBox
@onready var fullscreen = $"VBoxContainer/SettingsBox/VBox/Panel/VBoxContainer/FullScreen"



func _ready():
	SolarSettings.add_text_nodes([
		$VBoxContainer/SettingsBox/VBox/Panel/VBoxContainer/Copyright,
		$VBoxContainer/SettingsBox/VBox/Panel/VBoxContainer/Warning,
		$VBoxContainer/SettingsBox/VBox/Panel/VBoxContainer/DFText,
		$VBoxContainer/SettingsBox/VBox/Panel/VBoxContainer/FSText,
		$VBoxContainer/SettingsBox/VBox/Header/Settings,
	])

# TODO: fix esc toggling button
#func _unhandled_input(event):
#	if event is InputEventKey:
#		if event.keycode == KEY_ESCAPE:
#			print('test')
#			fullscreen.button_pressed = false


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
	if button_pressed:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		JavaScriptBridge.eval("document.querySelector('body').requestFullscreen()")
	else:
#		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		JavaScriptBridge.eval("document.exitFullscreen()")


func _on_dyslexia_font_toggled(button_pressed):
	SolarSettings.current_font = "dyslexic" if button_pressed else "standard" 

