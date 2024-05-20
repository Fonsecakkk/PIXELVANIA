extends Area2D

func _on_body_entered(body):
	if body.name == 'Character':
		print("oi")
		get_tree().change_scene_to_file("res://imagens rapidas/levels/scenes/teset_level_2.tscn")
		

	
