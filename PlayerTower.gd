extends Node2D

var target_position = Vector2.ZERO
var fire_timer = 0  # Add a new variable to keep track of time since last shot
export var fire_rate = 0.45  # Add a new export variable for the rate of fire

#var bullet_scene = load("res://Bullet.tscn")
onready var bullet_scene = preload("res://Bullet.tscn")

func _ready():
	set_position(get_viewport_rect().size / 2)
#	target_position = get_viewport_rect().size / 2

func _process(delta):
	fire_timer+=delta
	
func _input(event):
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
#	if (event is InputEventMouseMotion and event.button_mask == BUTTON_MASK_LEFT) or event is InputEventMouseButton:
	if Input.is_mouse_button_pressed( 1 ): # Left click
		var bullet_direction = (position - global_position).normalized()
		var angle = bullet_direction.angle()
		rotation = angle
		shoot(event.position)

func shoot(target_position):
	var bullet_direction = (target_position - global_position).normalized()
	var angle = bullet_direction.angle()
	rotation = angle
	if fire_timer >= fire_rate:
		var bullet = bullet_scene.instance()
	#	var bullet_direction = Vector2(1, 0).rotated(rotation)
#		var bullet_direction = (target_position - global_position).normalized()
#		var angle = bullet_direction.angle()
#		rotation = angle
		bullet.set_position(global_position + bullet_direction * 30)  # Offset from the AutoTower's center
		bullet.set_velocity(bullet_direction * 1000)  # Set the bullet's velocity to move it forward
		get_parent().add_child(bullet)  # Add the bullet to the scene
		fire_timer = 0
