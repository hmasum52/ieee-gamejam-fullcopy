extends CanvasLayer

func _on_PlayAgain_pressed():
	get_tree().reload_current_scene()
	PlayerStats.set_health(10)
	queue_free()


func _on_Quit_pressed():
	print("Quiting game")
	get_tree().quit()
