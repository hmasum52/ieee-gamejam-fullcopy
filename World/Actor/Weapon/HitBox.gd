extends Area2D

signal hit_something

func _on_body_entered(body):
	PlayerStats.health -= 1
	emit_signal("hit_something")


func _on_area_entered(area):
	print("Player was hit")
	emit_signal("hit_something")
