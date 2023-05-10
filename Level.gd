extends Node2D


var enemy_scene = preload("res://Enemy.tscn")
var auto_tower_scene = preload("res://AutoTower.tscn")
onready var score_label = get_node("ScoreLabel")
onready var save_manager = get_node("SaveManager")
onready var auto_tower_count = 1
var enemy_timer = 1
onready var enemy_spawn_delay = float(save_manager.load_result("ENEMY_SPAWN_DELAY"))

func _ready():
	for AT in auto_tower_count:
		add_new_tower()

func add_new_tower():
	var auto_tower = auto_tower_scene.instance()
	add_child(auto_tower)

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
