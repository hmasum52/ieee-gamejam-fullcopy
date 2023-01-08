tool
extends Area2D


export(NodePath) var source = ""
export(Vector2) var teleport_direction = Vector2(0,0)

var teleport_node = null


func _ready():
	if source != "":
		teleport_node = get_node(source)


func _draw():
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO,5,Color.green)
		draw_line(Vector2.ZERO,get_node(source).position-position,Color.red,3)
