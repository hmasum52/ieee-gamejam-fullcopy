extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String) var start = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	play(0.15)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
