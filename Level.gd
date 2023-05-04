

extends Node2D

var enemy_timer = 1
var enemy_spawn_delay = 0.60
var enemy_scene = preload("res://Enemy.tscn")
onready var score_label = get_node("ScoreLabel")


func _process(delta):
	enemy_timer -= delta
	if enemy_timer <= 0:
		enemy_timer = enemy_spawn_delay
		var enemy = enemy_scene.instance()
		add_child(enemy)
		var viewport_rect = get_viewport_rect()
		var spawn_side = rand_range(0, 1)
		if spawn_side > 0.5:
			# Spawn from top
			enemy.position = Vector2(rand_range(0, viewport_rect.size.x), -20)
		else:
			# Spawn from bottom
			enemy.position = Vector2(rand_range(0, viewport_rect.size.x), viewport_rect.size.y + 20)
