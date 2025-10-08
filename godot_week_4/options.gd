extends CanvasLayer

var volume = 0
var darkness = 0.8

signal go_back

signal up_light

signal resume_game

func _ready() -> void:
	$VolumeValue.text = str(volume)
	$LightingValue.text = str(int(round(darkness * 100)))

func _on_back_button_pressed() -> void:
	$SelectSFX.play()
	go_back.emit()

func _on_volume_up_pressed() -> void:
	volume += 1
	$SelectSFX.play()
	$VolumeValue.text = str(volume)
	
	if (volume > 15):
		$VolumeValue.add_theme_color_override("font_color", Color.html("#ff5b5b"))
	elif (volume < -10):
		$VolumeValue.add_theme_color_override("font_color", Color.html("#5beeee"))
	else:
		$VolumeValue.add_theme_color_override("font_color", Color.html("#ffffff"))
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)
	$SelectSFX.play()

func _on_volume_down_pressed() -> void:
	volume -= 1
	$SelectSFX.play()
	$VolumeValue.text = str(volume)
	
	if (volume > 15):
		$VolumeValue.add_theme_color_override("font_color", Color.html("#ff5b5b"))
	elif (volume < -10):
		$VolumeValue.add_theme_color_override("font_color", Color.html("#5beeee"))
	else:
		$VolumeValue.add_theme_color_override("font_color", Color.html("#ffffff"))
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), volume)
	$SelectSFX.play()
	

func _on_light_vol_up_pressed() -> void:
	darkness += 0.05
	darkness = snapped(darkness, 0.01)
	if (darkness >= 1):
		darkness = 1
		
	$SelectSFX.play()
		
	$LightingValue.text = str(int(round(darkness * 100)))
	$SelectSFX.play()
	up_light.emit()

func _on_light_vol_down_pressed() -> void:
	darkness -= 0.05
	darkness = snapped(darkness, 0.01)
	if (darkness <= 0):
		darkness = 0
		
	$SelectSFX.play()
		
	$LightingValue.text = str(int(round(darkness * 100)))
	$SelectSFX.play()
	up_light.emit()
	
func _process(delta):
	if Input.is_action_just_pressed("pause") && get_tree().paused:
		var parent = get_parent()
		
		if parent.in_game && parent.in_options:
			get_tree().paused = false
			resume_game.emit()
