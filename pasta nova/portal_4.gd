extends Area2D

func _on_body_entered(body):
	if body.name == 'player':
		print("oi")
		get_tree().change_scene_to_file("res://pasta nova/level_4.tscn")
		

	

