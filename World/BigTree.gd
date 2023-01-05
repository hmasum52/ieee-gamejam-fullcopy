extends StaticBody2D


func _on_Area2D_area_entered(area):
	set_modulate(Color(1, 1, 1, 0.3))
	print("Area Entered")


func _on_Area2D_area_exited(area):
	#modulate.a = 255
	set_modulate(Color(1, 1, 1, 1))
	print("Area Exited")
