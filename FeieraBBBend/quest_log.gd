extends Control

var is_open = false

func _ready():
	$RichTextLabel.text = "[b][i]No quests accepted yet[i][b]"
	close()

func _process(delta):
	if Input.is_action_just_pressed("q"):
		if is_open:
			close()
		else:
			open()

func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
	
func update_quest_log():
	if global.found_teacher_item == true:
		$RichTextLabel.text = "[b]You've completed all quests in this level![b]"
	elif global.accepted_quest == true:
		$RichTextLabel.text = "[b]Collect paper for the teacher and bring it back to him.[b]"
		global.accepted_quest = false
