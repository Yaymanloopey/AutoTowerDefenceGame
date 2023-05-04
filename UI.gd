extends Node2D

onready var level = get_tree().get_root().get_node("Level")
onready var auto_tower = level.get_node("AutoTower")
onready var player_tower = level.get_node("PlayerTower")
onready var save_manager = level.get_node("SaveManager")
onready var score_label = get_node("CanvasLayer/ScoreLabelControl/ScoreGrid/ScoreLabel")
onready var points_label = get_node("CanvasLayer/ScoreLabelControl/ScoreGrid/PointsLabel")
onready var attack_speed_button_label = get_node("CanvasLayer/MarginContainer/ButtonGrid/AttackSpeedButton")
onready var attack_power_button_label = get_node("CanvasLayer/MarginContainer/ButtonGrid/AttackPowerButton")
onready var enemy_health_button_label = get_node("CanvasLayer/MarginContainer/ButtonGrid/EnemyHealthButton")

var score
var points

func _ready():
	attack_speed_button_label.text = "Attack Speed (" + str(save_manager.load_result("ATTACK_SPEED_COST")) + ")"
	enemy_health_button_label.text = "Enemy_health (" + str(save_manager.load_result("ENEMY_HEALTH_COST")) + ")"
	update_score_label()
	update_points_label()

func _process(delta):
	pass

func update_score_label():
	var saved_score = int(save_manager.load_result("SCORE"))
	score = saved_score
	score_label.text = "Score: " + str(score)

func update_points_label():
	var saved_points = int(save_manager.load_result("POINTS"))
	points = saved_points
	points_label.text = "Points: " + str(points)

func _on_AttackSpeedButton_pressed():
	#UPDATING THE ATTACK SPEED COST
	var attack_speed_cost = int(save_manager.load_result("ATTACK_SPEED_COST"))
	var current_points = int(save_manager.load_result("POINTS"))
	if attack_speed_cost < current_points:
		update_attack_speed_cost()
#		update_upgrade_cost("ATTACK_SPEED")
		update_points_label()
		#UPDATING THE ACTUAL ATTACK SPEED RATE
		update_attack_speed()
	else:
		print("Earn More Points")
		
#func update_upgrade_cost(column_name: String):
#	var current_cost = int(save_manager.load_result(column_name.to_upper()))
#	print("Current Cost "+ str(current_cost))
#	var new_cost = int(current_cost)*1.5
#	print("New Cost "+ str(current_cost))
#	save_manager.save_result(column_name.to_upper(), new_cost)
#	var saved_points = int(save_manager.load_result("POINTS"))
#	var new_points = saved_points - current_cost
#	save_manager.save_result("POINTS",new_points)
#
#	if column_name.to_upper() == "ATTACK_SPEED":
#		attack_speed_button_label.text = "Attack Speed (" + str(new_cost) + ")"
#	elif column_name.to_upper() == "ENEMY_HEALTH":
#		enemy_health_button_label.text = "Enemy Health (" + str(new_cost) + ")"
#	elif column_name.to_upper() == "ATTACK_POWER":
#		attack_power_button_label.text = "Attack Power (" + str(new_cost) + ")"
		
func update_attack_speed_cost():
	var attack_speed_cost = int(save_manager.load_result("ATTACK_SPEED_COST"))
	var new_attack_speed_cost = int(attack_speed_cost)*2
	save_manager.save_result("ATTACK_SPEED_COST", new_attack_speed_cost)
	attack_speed_button_label.text = "Attack Speed (" + str(new_attack_speed_cost) + ")"
	var saved_points = int(save_manager.load_result("POINTS"))
	var new_points = saved_points - attack_speed_cost
	save_manager.save_result("POINTS",new_points)
	
func update_attack_speed():
	var attack_speed = float(save_manager.load_result("ATTACK_SPEED"))
	print("Attack Speed: "+ str(attack_speed))
	var new_attack_speed = float(attack_speed)*0.95
	print("new attack speed: " + str(new_attack_speed))
	save_manager.save_result("ATTACK_SPEED", new_attack_speed)
	player_tower.fire_rate = new_attack_speed
	
func _on_EnemyHealthButton_pressed():
	#UPDATING THE ENEMY HEALTH COST
	var enemy_health_cost = int(save_manager.load_result("ENEMY_HEALTH_COST"))
	var current_points = int(save_manager.load_result("POINTS"))
	if enemy_health_cost < current_points:
		update_enemy_health_cost()
#		update_upgrade_cost("ENEMY_HEALTH")
		update_points_label()
		#UPDATING THE ACTUAL ATTACK SPEED RATE
		update_enemy_health()
	else:
		print("Earn More Points")
		
func update_enemy_health_cost():
	var enemy_health_cost = int(save_manager.load_result("ENEMY_HEALTH_COST"))
	var new_enemy_health_cost = int(enemy_health_cost)*2
	save_manager.save_result("ENEMY_HEALTH_COST", new_enemy_health_cost)
	enemy_health_button_label.text = "Enemy Health (" + str(new_enemy_health_cost) + ")"
	var saved_points = int(save_manager.load_result("POINTS"))
	var new_points = saved_points - enemy_health_cost
	save_manager.save_result("POINTS",new_points)

func update_enemy_health():
	var enemy_health = float(save_manager.load_result("ENEMY_HEALTH"))
	print("Enemy Health: "+ str(enemy_health))
	var new_enemy_health = int(enemy_health)+1
	print("new enemy health: " + str(new_enemy_health))
	save_manager.save_result("ENEMY_HEALTH", new_enemy_health)
	player_tower.fire_rate = new_enemy_health

func _on_TopBorderControl_resized():
	var top_border = get_node("CanvasLayer/TopBorderControl/TopBorder")
	var bottom_border = get_node("CanvasLayer/BottomBorderControl/BottomBorder")
	var button_grid = get_node("CanvasLayer/MarginContainer/ButtonGrid")
	top_border.rect_size.x = get_viewport_rect().size.x
	bottom_border.rect_size.x = get_viewport_rect().size.x
#	button_grod.
	# placing the towers into the centre of the screen on re-size
	if auto_tower != null:
		auto_tower.set_tower_position()
	if player_tower != null:
		player_tower.set_tower_position()
