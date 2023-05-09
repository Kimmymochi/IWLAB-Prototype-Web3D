extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_button_toggled(button_pressed):
	if(button_pressed):
		$Margin/VBox/HBox/Button.icon = load("res://icons/window-close-custom.png")
		$Margin/VBox/CanvasLayer/PanelContainer.visible = true
	else:
		$Margin/VBox/HBox/Button.icon = load("res://icons/cog-custom.png")
		$Margin/VBox/CanvasLayer/PanelContainer.visible = false
		
	
