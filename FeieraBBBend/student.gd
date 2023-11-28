extends CharacterBody2D

@export var max_speed := 300
var desired_velocity := Vector2.ZERO
var steering_velcoity := Vector2.ZERO
var teacher_in_range = false
var in_paper_dec = false

func _physics_process(delta: float) -> void:
	var direction =  Input.get_vector('move_left', 'move_right', 'move_up', "move_down")
	desired_velocity = direction * max_speed
	steering_velcoity = desired_velocity - velocity
	velocity += steering_velcoity
	# rotation = velocity.angle()

	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walking")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walking/blend_position", velocity)
		move_and_slide()	

	if teacher_in_range == true:
		if Input.is_action_just_pressed("accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://main.dialogue"), "main")
			return
			
	if in_paper_dec == true:
		if Input.is_action_just_pressed("accept"):
			global.found_teacher_item = true

func _process(delta):
	if in_paper_dec == true:
		pass

func _on_detection_body_entered(body):
	if body.has_method("teacher"):
		teacher_in_range = true

func _on_detection_paper_body_entered(body):
	if body.has_method("student"):
		in_paper_dec = true


func _on_detection_paper_body_exited(body):
	if body.has_method("student"):
		in_paper_dec = false


func _on_detection_body_exited(body):
	if body.has_method("teacher"):
		teacher_in_range = false

func student():
	pass
	

	


