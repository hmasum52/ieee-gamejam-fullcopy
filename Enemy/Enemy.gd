extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
var knockback: Vector2 = Vector2.ZERO
var velocity = Vector2.ZERO

export var FRICTION = 400
export var ACCELERATION = 300
export var MAX_SPEED = 50

onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone

onready var animationPlayer: AnimationPlayer = $AnimationPlayer
onready var animationTree : AnimationTree = $AnimationTree
onready var animationState : AnimationNodeStateMachinePlayback = animationTree.get("parameters/playback")


enum {
	IDLE, 
	WANDER,
	CHASE
}

var state = CHASE

func _ready():
	animationTree.active = true

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player 
			if (player != null):
				var dir = (player.global_position - global_position).normalized()
				animationTree.set("parameters/Idle/blend_position", dir)
				animationTree.set("parameters/Run/blend_position", dir)
				velocity = velocity.move_toward(dir * MAX_SPEED, ACCELERATION * delta)
			else:
				state = IDLE
				
	velocity = move_and_slide(velocity)
	if velocity != Vector2.ZERO:
		animationState.travel("Run")
	else:
		animationState.travel("Idle")
		
func seek_player():
	if (playerDetectionZone.can_see_player()):
		state = CHASE

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector *120


func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	enemyDeathEffect.global_position = global_position
	get_parent().add_child(enemyDeathEffect)
