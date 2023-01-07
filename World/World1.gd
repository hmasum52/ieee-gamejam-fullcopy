extends Node2D


onready var canvasmodulate = $CanvasModulate

func _ready():
	print("World is ready")
	#$CanvasModulate.set_color(Color(1, 1, 1, 0))
	$CanvasModulate.visible = false
	print($CanvasModulate.visible)


func _on_Map2_area_entered(area):
	$CanvasModulate.visible  = true
	

func _on_Map2_area_exited(area):
	$CanvasModulate.visible = false


func _on_Map1_area_entered(area):
	$CanvasModulate.visible = false
