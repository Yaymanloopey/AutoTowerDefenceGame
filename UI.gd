extends Node2D

onready var level = get_tree().get_root().get_node("Level")
onready var auto_tower = level.get_node("AutoTower")
onready var player_tower = level.get_node("PlayerTower")
onready var save_manager = level.get_node("SaveManager")
onready var score_label = get_node("CanvasLayer/ScoreLabelControl/ScoreLabel")
onready var attack_speed_button_label = get_node("CanvasLayer/AttackSpeedButtonControl/AttackSpeedButton")
var score

func _ready():
	attack_speed_button_label.text = "Attack Speed (" + str(save_manager.load_result("ATTACK_SPEED_COST")) + ")"
	update_score_label()

func _process(delta):
	pass

func update_score_label():
	var saved_score = save_manager.load_result("SCORE")
	score = saved_score
	score_label.text = "Score: " + str(score)


func _on_Control5_resized():
	var top_border = get_node("CanvasLayer/Control5/TopBorder")
	var bottom_border = get_node("CanvasLayer/Control6/BottomBorder")
	top_border.rect_size.x = get_viewport_rect().size.x
	bottom_border.rect_size.x = get_viewport_rect().size.x


func _on_AttackSpeedButton_pressed():
	#UPDATING THE ATTACK SPEED COST
	var attack_speed_cost = save_manager.load_result("ATTACK_SPEED_COST")
	var current_score = save_manager.load_result("SCORE")
	if attack_speed_cost < current_score:
		update_attack_speed_cost()
		update_score_label()
		#UPDATING THE ACTUAL ATTACK SPEED RATE
		update_attack_speed()
	else:
		print("Earn More Points")

func update_attack_speed_cost():
	var attack_speed_cost = save_manager.load_result("ATTACK_SPEED_COST")
	var new_attack_speed_cost = int(attack_speed_cost)*2
	save_manager.save_result("ATTACK_SPEED_COST", new_attack_speed_cost)
	attack_speed_button_label.text = "Attack Speed (" + str(new_attack_speed_cost) + ")"
	var saved_score = save_manager.load_result("SCORE")
	var new_score = saved_score - attack_speed_cost
	save_manager.save_result("SCORE",new_score)

func update_attack_speed():
	var attack_speed = float(save_manager.load_result("ATTACK_SPEED"))
	print("Attack Speed: "+ str(attack_speed))
	var new_attack_speed = float(attack_speed)*0.95
	print("new attack speed: " + str(new_attack_speed))
	save_manager.save_result("ATTACK_SPEED", new_attack_speed)
	player_tower.fire_rate = new_attack_speed
