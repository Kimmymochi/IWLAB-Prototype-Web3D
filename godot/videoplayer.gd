extends Node

const player_html = '<iframe src="" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen> </iframe>'
var video_source = ""


func _ready():
	SolarSettings.settings_view_toggled.connect(toggle_visibility)
	SolarSettings.planet_view_toggled.connect(toggle_visibility)


func show_video(video_id : String, rect : Rect2):
	if JavaScriptBridge.eval("!document.querySelector('iframe')"):
		JavaScriptBridge.eval("document.body.appendChild(document.createElement('iframe'))")
		JavaScriptBridge.eval("document.querySelector('iframe').outerHTML = '"+ player_html + "'")
		JavaScriptBridge.eval("document.querySelector('iframe').style.position = 'absolute'")
	video_source = "https://player.ntr.nl/?mid=" + video_id
	JavaScriptBridge.eval("document.querySelector('iframe').src = '" + video_source + "'")
	resize_video(rect)
	

	

func resize_video(rect):
	JavaScriptBridge.eval("document.querySelector('iframe').style.top = `"+ str(rect.position.y) + "%`")
	JavaScriptBridge.eval("document.querySelector('iframe').style.left = `"+ str(rect.position.x) + "%`")
	JavaScriptBridge.eval("document.querySelector('iframe').style.height = `"+ str(rect.size.y) + "%`")
	JavaScriptBridge.eval("document.querySelector('iframe').style.aspectRatio = '16 / 9'")
	


func toggle_visibility():
	if video_source != "" and JavaScriptBridge.eval("!!document.querySelector('iframe')"):
		if SolarSettings.in_planet_view == "" or SolarSettings.in_settings_view:
			JavaScriptBridge.eval("document.querySelector('iframe').style.display = 'none'")
			JavaScriptBridge.eval("document.querySelector('iframe').src = ''")

		else:
			JavaScriptBridge.eval("document.querySelector('iframe').style.display = 'block'")
			JavaScriptBridge.eval("document.querySelector('iframe').src = '" + video_source + "'")

#
