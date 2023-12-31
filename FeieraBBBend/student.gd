extends CharacterBody2D

@export var max_speed := 300
@export var inv: Inv
var desired_velocity := Vector2.ZERO
var steering_velcoity := Vector2.ZERO
var teacher_in_range = false
var in_paper_dec = false

var enemy_inattackrange = false
var enemy_attackcooldown = true 
var health = 100
var player_alive = true

func _physics_process(delta: float) -> void:
	var direction =  Input.get_vector('move_left', 'move_right', 'move_up', "move_down")
	desired_velocity = direction * max_speed
	steering_velcoity = desired_velocity - velocity
	velocity += steering_velcoity
	# rotation = velocity.angle()
	enemy_attack()
	update_health()
	
	
	if health <= 0:
		health = 0
		print("player died")
		get_tree().reload_current_scene()

	

	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walking")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walking/blend_position", velocity)
		move_and_slide()	

	if teacher_in_range == true:
		if Input.is_action_just_pressed("accept") && global.accepted_quest == false:
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main")
			global.accepted_quest = true
			$QuestLog.update_quest_log()
			return
		elif Input.is_action_just_pressed("accept"):
			DialogueManager.show_example_dialogue_balloon(load("res://dialogue/main.dialogue"), "main")
			$QuestLog.update_quest_log()
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

func collect(item):
	inv.insert(item)


func _on_student_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_inattackrange = true


func _on_student_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_inattackrange = false

func enemy_attack():
	if enemy_inattackrange and enemy_attackcooldown == true:
		health -= 20
		enemy_attackcooldown = false
		$attack_cooldown.start()
		print(health)


func _on_attack_cooldown_timeout():
	enemy_attackcooldown = true


func update_health():
	var HealthBar = $HealthBar
	HealthBar.value = health
	
	if health >= 100:
		HealthBar.visible = false
	else:
		HealthBar.visible = true

func _on_regin_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
