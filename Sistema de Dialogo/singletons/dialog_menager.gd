extends Node

@onready var dialogue_box_scene = preload("res://Sistema de Dialogo/Scenes/dialog_box.tscn")
var message_lines : Array[String] = []
var current_Line = 0

var dialog_box
var dialog_box_position := Vector2.ZERO

var is_message_active := false
var can_advance_message := false

func start_message(position: Vector2, lines: Array[String]):
	if is_message_active:
		return
		
	message_lines = lines
	dialog_box_position = position
	show_text()
	is_message_active = true
	
func show_text():
	dialog_box = dialog_box_scene.instantiate()
	dialog_box.text_display_finished.connect()
