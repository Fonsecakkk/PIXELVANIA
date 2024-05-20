extends Control

func _ready():
	$Returnbtn.grab_focus()
	

func _on_returnbtn_pressed():
	get_tree().change_scene_to_file("res://Scenes/start_screen.tscn")
	
