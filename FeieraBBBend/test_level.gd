extends Node2D

func _process(delta):
	if global.found_teacher_item == true:
		$paper.visible = false;
