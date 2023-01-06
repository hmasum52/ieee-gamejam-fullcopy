extends KinematicBody2D

# player state
enum {
	MOVE,
	ROLL,
	ATTACK
}
var state = MOVE # default initial value

const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500
var velocity: = Vector2.ZERO

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var animationTree : AnimationTree = $AnimationTree
onready var animationState : AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true
	get_node("HitboxPivot/SwordHitbox/CollisionShape2D").disabled = true

func _physics_process(delta):
	# determine which state to run
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vec = Vector2.ZERO
	input_vec.x = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	input_vec.y = Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")
	input_vec = input_vec.normalized() # slow down diagonal speed
	if input_vec != Vector2.ZERO: 
		animationTree.set("parameters/Steady/blend_position", input_vec)
		animationTree.set("parameters/Running/blend_position", input_vec)
		animationTree.set("parameters/Fighting/blend_position", input_vec)
		animationState.travel("Running")
		velocity = velocity.move_toward(input_vec*MAX_SPEED, ACCELERATION * delta)
		get_node("HitboxPivot/SwordHitbox").knockback_vector = input_vec
	else:
		animationState.travel("Steady")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
	
	velocity = move_and_slide(velocity)

	if Input.is_action_just_pressed("attack"):
		# print("Swtiching to attach state")
		velocity = Vector2.ZERO
		state = ATTACK

func attack_state(delta):
	animationState.travel("Fighting")

func attack_animation_finished():
	# print("attack animation finished")
	state = MOVE
