extends KinematicBody2D

var velocity = Vector2.ZERO
var collision_shape = null

func set_velocity(velocity: Vector2) -> void:
	self.velocity = velocity

#func _ready():


func _process(delta):
	# Move the bullet based on its velocity
	move_and_slide(velocity)
	# Set the position of the parent node to match the child's position

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		queue_free()
