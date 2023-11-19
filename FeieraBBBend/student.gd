extends CharacterBody2D

@export var max_speed := 300
var desired_velocity := Vector2.ZERO
var steering_velcoity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	var direction =  Input.get_vector('move_left', 'move_right', 'move_up', "move_down")
	desired_velocity = direction * max_speed
	steering_velcoity = desired_velocity - velocity
	velocity += steering_velcoity
	rotation = velocity.angle()
	move_and_slide()
