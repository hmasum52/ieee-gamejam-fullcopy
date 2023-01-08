tool
extends Area2D


export(NodePath) var target = ""
export(Vector2) var teleport_direction = Vector2(0,0)

var teleport_node = null

func _ready():
	if target != "":
		teleport_node = get_node(target)

func _on_body_entered(body):
	print(body)
	body.global_position = teleport_node.global_position+teleport_direction*10
	



func _draw():
	if Engine.is_editor_hint():
		draw_circle(Vector2.ZERO,5,Color.red)
		draw_line(Vector2.ZERO,get_node(target).position-position,Color.red,3)
