extends StaticBody2D

@export var item: InvItem
var student = null
var student_in_area = false

func _on_detection_paper_body_entered(body):
	if body.has_method("student"):
		student_in_area = true
		student = body
		student.collect(item)
		global.found_teacher_item = true
		self.queue_free()


func _on_detection_paper_body_exited(body):
	if body.has_method("student"):
		student_in_area = false


