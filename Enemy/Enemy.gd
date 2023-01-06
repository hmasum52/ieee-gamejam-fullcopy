extends KinematicBody2D

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")
var knockback: Vector2 = Vector2.ZERO

onready var stats = $Stats

func _ready():
	print(stats.max_health)
	

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
	knockback = move_and_slide(knockback)


func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector *120


func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	enemyDeathEffect.global_position = global_position
	get_parent().add_child(enemyDeathEffect)