extends Node2D

onready var level = get_tree().get_root().get_node("Level")
onready var auto_tower = level.get_node("AutoTower")
onready var player_tower = level.get_node("PlayerTower")
onready var save_manager = level.get_node("SaveManager")
onready var score_label = get_node("CanvasLayer/ScoreLabelControl/ScoreLabel")
var score

func _ready():
	var level = get_tree().get_root().get_node("Level")
	var save_manager = level.get_node("SaveManager")
	var saved_score = save_manager.load_score()
	score = saved_score
	update_score_label()

func _process(delta):
	pass

func update_score_label():
	var saved_score = save_manager.load_score()
	score = saved_score
	score_label.text = "Score: " + str(score)


func _on_Control5_resized():
	var top_border = get_node("CanvasLayer/Control5/TopBorder")
	var bottom_border = get_node("CanvasLayer/Control6/BottomBorder")
	top_border.rect_size.x = get_viewport_rect().size.x
	bottom_border.rect_size.x = get_viewport_rect().size.x


func _on_AttackSpeedButton_pressed():
	var saved_score = save_manager.load_score()
	var new_score = saved_score - 10
	save_manager.save_score(new_score)
	update_score_label()
	player_tower.fire_rate = player_tower.fire_rate *0.95
