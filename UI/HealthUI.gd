extends Control

var hearts = 5 setget set_hearts
var max_hearts = 5 setget set_max_hearts

onready var heart_ui_full = $HeartUIFull
onready var heart_ui_empty = $HeartUIEmpty


func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heart_ui_full != null:
		heart_ui_full.set_size(Vector2(hearts * 15, 11))
	
func set_max_hearts(value):
	max_hearts = max(value, 1)
	self.hearts = min(hearts, max_hearts)
	if heart_ui_empty != null:
		heart_ui_empty.set_size(Vector2(max_hearts * 15, 11))

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health 
	PlayerStats.connect("health_changed", self, "set_hearts")
	PlayerStats.connect("max_health_change", self, "set_max_hearts")
