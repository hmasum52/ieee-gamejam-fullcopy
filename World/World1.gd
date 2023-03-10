extends Node2D


onready var canvasmodulate = $CanvasModulate

func _ready():
	print("World is ready")
	$CanvasModulate.visible = false
	$Maps/Player/Light2D.visible = false
	var dialogic = Dialogic.start("Background")
	add_child(dialogic)


func _on_Map2_area_entered(area):
	$CanvasModulate.visible  = true
	$Maps/Player/Light2D.visible = true
	var dialogic = Dialogic.start("Dungeon")
	add_child(dialogic)
	

func _on_Map2_area_exited(area):
	$CanvasModulate.visible = false
	$Maps/Player/Light2D.visible = false
	print("Map2 exited")
	var dialogic = Dialogic.start("Surprise Boss")
	add_child(dialogic)
