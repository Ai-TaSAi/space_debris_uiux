extends Control

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		
		var parent_in_game = get_parent().in_game
		
		if (parent_in_game && !get_tree().paused):
			$ColorRect.show()
			$Label.show()
			get_tree().paused = true
		elif (parent_in_game && get_tree().paused):
			print("UNPAUSE!")
			$ColorRect.hide()
			$Label.hide()
			get_tree().paused = false
