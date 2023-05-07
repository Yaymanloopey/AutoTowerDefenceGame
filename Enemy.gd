extends KinematicBody2D


onready var level = get_tree().get_root().get_node("Level")
onready var auto_tower = level.get_node("AutoTower")
onready var save_manager = level.get_node("SaveManager")
onready var UI = level.get_node("UI")

export var speed = 50

onready var hitpoints = int(save_manager.load_result("ENEMY_HEALTH"))
var hits = 0
var saved_score = 0
var target_position = Vector2.ZERO


func _ready():
#	target_position = get_viewport_rect().size / 2
	target_position = auto_tower.position
	
#	target_position = get_tree().root.get_node("AutoTower").position

func _process(delta):
	position = position.move_toward(target_position, delta * speed)

func _on_Area2D_body_entered(body):
	var damage = int(save_manager.load_result("ATTACK_POWER"))
	var saved_score = int(save_manager.load_result("SCORE"))
	var saved_points = int(save_manager.load_result("POINTS"))
	if body.is_in_group("Bullet"):
		hits += damage
		# If the enemy has been hit max_hits times, remove it from the scene + save new score
		if hits >= hitpoints:
			var new_score = saved_score + 1
			var new_points = hitpoints + saved_points
			save_manager.save_result("SCORE",new_score)
			save_manager.save_result("POINTS",new_points)
			UI.update_score_label()
			UI.update_points_label()
			queue_free()
	elif body.is_in_group("AutoTower"):
		# If the enemy touches the AutoTower then disappear
		queue_free()
