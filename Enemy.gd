extends KinematicBody2D

export var speed = 50
export var hitpoints = 2
var hits = 0
var saved_score = 0
var target_position = Vector2.ZERO
onready var level = get_tree().get_root().get_node("Level")
onready var auto_tower = level.get_node("AutoTower")
onready var save_manager = level.get_node("SaveManager")
onready var UI = level.get_node("UI")


func _ready():
#	target_position = get_viewport_rect().size / 2
	target_position = auto_tower.position
	
#	target_position = get_tree().root.get_node("AutoTower").position

func _process(delta):
	position = position.move_toward(target_position, delta * speed)

func _on_Area2D_body_entered(body):
	var saved_score = save_manager.load_score()
	if body.is_in_group("Bullet"):
		hits += 1
#		print(hits)
		# If the enemy has been hit max_hits times, remove it from the scene + save new score
		if hits >= hitpoints:
			var new_score = hitpoints + saved_score
			save_manager.save_score(new_score)
			UI.update_score_label()
			queue_free()
	elif body.is_in_group("AutoTower"):
		# If the enemy touches the AutoTower then disappear
		queue_free()
