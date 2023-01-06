extends StaticBody2D

onready var animationTree: AnimationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true


func _process(delta):
	if Input.is_action_just_pressed("attack"):
		print("attack")
		animationState.travel("Open")
