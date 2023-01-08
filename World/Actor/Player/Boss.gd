extends KinematicBody2D

signal change_direction(direction)
signal velocity_changed(velocity)
signal action_pressed()
signal hit(damage)
signal position_changed(position)

var left:bool = false
var right:bool = false
var up:bool = false
var down:bool = false
var move_axis:Vector2 = Vector2() setget set_move_axis
var speed:float = 40
var velocity:Vector2 = Vector2() setget set_velocity
var push_velocity:Vector2 = Vector2()
var bloc_move = false
var disabled = false setget set_disabled
onready var start_pos = global_position
onready var life_bar:TextureProgress = $HealthBar


onready var tween:Tween = $Sprite/Tween
onready var sprite:AnimatedSprite = $Sprite
onready var playerDetectionZone = $PlayerDetectionZone
onready var weaponDetectionZone = $WeaponDetectionZone
onready var stats = $Stats


func _process(delta):
	
	
	if weaponDetectionZone.player != null:
		emit_signal("action_pressed")
		self.move_axis = Vector2.ZERO
		self.velocity = Vector2.ZERO
	elif playerDetectionZone.player != null:
		self.move_axis = (playerDetectionZone.player.global_position - global_position).normalized()
		print(self.move_axis)
		
	else:
		self.move_axis = Vector2(0, 0)
		


func _physics_process(delta):
	push_velocity = Vector2(0, 0)
	
	if (playerDetectionZone.player != null):
		move_and_slide(Vector2(3, 3))
	velocity = move_and_slide((velocity+push_velocity).floor())
	emit_signal("position_changed",global_position)


func set_direction(direction):
	emit_signal("change_direction",direction)


func set_move_axis(v):
	if disabled:
		return
	if move_axis != v:
		if v.length():
			emit_signal("change_direction",v)
	self.velocity = move_axis*speed
	move_axis = v


func set_velocity(v):
	velocity = v
	emit_signal("velocity_changed",velocity)


func _on_ActionTime_timeout():
	bloc_move = false


func hit(damage = 1):
	emit_signal("hit",damage)
	hit_fx()


func death():
	self.disabled = true
	sprite.animation = "Death"
	yield(get_tree().create_timer(0.5,false),"timeout")
	get_tree().call_group("Hud","revive")
	reset()


func reset():
	global_position = start_pos
	self.disabled = false


func push(from,force):
	push_velocity = (global_position-from).normalized()*force


func hit_fx():
	tween.interpolate_property(sprite,"scale",Vector2(2,2),Vector2.ONE,0.2,Tween.TRANS_CIRC,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"modulate",Color(50,50,50),Color.white,0.2,Tween.TRANS_CIRC,Tween.EASE_OUT)
	$SndHit.play()
	tween.start()


func set_disabled(v):
	disabled = v
	set_process(!v)
	set_physics_process(!v)


func _on_HurtBox_area_entered(area):
	print("Attacked by player")
	stats.health -= 2
	life_bar.set_value(stats.health)
	print(stats.health)
	if (stats.health <= 0):
		
		var dialogic = Dialogic.start("GameOver")
#		add_child(dialogic)
		get_tree().get_root().add_child(dialogic)
		queue_free()
