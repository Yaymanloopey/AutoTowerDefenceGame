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
	attack_power_button_label.text = "Attack Power (" + str(save_manager.load_result("ATTACK_POWER_COST")) + ")"	
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
	var skill_name = "ATTACK_SPEED"
	update_skill_details(skill_name)
		
	
func _on_EnemyHealthButton_pressed():
	var skill_name = "ENEMY_HEALTH"
	update_skill_details(skill_name)

func _on_AttackPowerButton_pressed():
	var skill_name = "ATTACK_POWER"
	update_skill_details(skill_name)

func update_skill_details(skill_name: String):
	#initiating variables
	var skill_cost = 0
	#defining dynamic skill cost string
	var skill_cost_string = str(skill_name) + "_COST" 
	var current_points = int(save_manager.load_result("POINTS"))
	
	skill_cost = int(save_manager.load_result(skill_cost_string))
			
	if skill_cost < current_points:
		update_skill_cost(skill_name, skill_cost_string)
		update_skill_stats(skill_name)
		update_points_label()
	else:
		print("Earn More Points")

func update_skill_cost(skill_name: String, skill_cost_string: String):
	#Intiating variables to be used
	var current_skill_cost = 0
	var new_skill_cost = 0
	var skill_button_label = str(skill_name) + "_button_label"
	var skill_label_text = ""
	#getting the current cost of the skill being updated 
	current_skill_cost = int(save_manager.load_result(skill_cost_string))
	#Multiply cost by 2
	new_skill_cost = current_skill_cost*2
	#save the new skill cost to the file
	save_manager.save_result(skill_cost_string, new_skill_cost)
	
	# Updating label
	if skill_name == "ENEMY_HEALTH":
		enemy_health_button_label.text = "Enemy Health (" + str(new_skill_cost) + ")"
	elif skill_name == "ATTACK_POWER":
		attack_power_button_label.text = "Attack Power (" + str(new_skill_cost) + ")"
	elif skill_name == "ATTACK_SPEED":
		attack_speed_button_label.text = "Attack Speed (" + str(new_skill_cost) + ")"
	
	var saved_points = int(save_manager.load_result("POINTS"))
	var new_points = saved_points - current_skill_cost
	save_manager.save_result("POINTS",new_points)

func update_skill_stats(skill_name: String):
	var skill_stat = float(save_manager.load_result(skill_name))
	var new_skill_stat = float(0)
	print("Current "+ str(skill_name) + ": " + str(skill_stat)) 
	
	if skill_name == "ENEMY_HEALTH":
		new_skill_stat = int(skill_stat) + 1
	elif skill_name == "ATTACK_POWER":
		new_skill_stat = int(skill_stat) + 1
	elif skill_name == "ATTACK_SPEED":
		new_skill_stat = float(skill_stat)*0.95
	
	print("New "+ str(skill_name) + ": " + str(new_skill_stat))
	
	save_manager.save_result(skill_name, new_skill_stat)
	
#	player_tower.fire_rate = new_enemy_health

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



