extends KinematicBody2D

export var speed = 1
export var rotation_speed = 5  # Add a new export variable for the rotation speed

onready var level = get_tree().get_root().get_node("Level")
onready var save_manager = level.get_node("SaveManager")

var target_position = Vector2.ZERO
var closest_enemy = null
var fire_timer = 0  # Add a new variable to keep track of time since last shot
export onready var fire_rate = float(save_manager.load_result("ATTACK_SPEED"))  # Add a new export variable for the rate of fire

onready var bullet_scene = preload("res://Bullet.tscn")  # Add a new variable to load the Bullet scene


func _ready():
	set_tower_position()
	
	
func set_tower_position() -> void:
	set_position(get_viewport_rect().size / 2)
	target_position = get_viewport_rect().size / 2

func _process(delta):
	# Find all enemies in the scene
	var enemies = get_tree().get_nodes_in_group("Enemy")

	# Find the closest enemy to the turret
	var closest_distance = 1000000
	closest_enemy = null
	for enemy in enemies:
		if enemy.global_position != null and global_position != null:
			var distance = global_position.distance_to(enemy.global_position)
			if distance < closest_distance:
				closest_distance = distance
				closest_enemy = enemy

	# Rotate the turret to face the closest enemy
	if closest_enemy != null:
		var bullet_direction = (closest_enemy.global_position - global_position).normalized()
#		var direction = closest_enemy.global_position
		var angle = bullet_direction.angle()
		rotation = angle
#		rotation = rotation.move_toward(angle, rotation_speed * delta)
		fire_timer -= delta
		if fire_timer <= 0:
			shoot()
			fire_timer = fire_rate
	else:
		pass
	

func shoot():
	# Spawn a Bullet instance and set its position and velocity based on the current rotation of the AutoTower
	var bullet = bullet_scene.instance()
	var bullet_direction = Vector2(1, 0).rotated(rotation)
	bullet.set_position(global_position + bullet_direction * 30)  # Offset from the AutoTower's center
	bullet.set_velocity(bullet_direction * 1000)  # Set the bullet's velocity to move it forward
	get_parent().add_child(bullet)  # Add the bullet to the scene

func print_hello():
	print("hello")
