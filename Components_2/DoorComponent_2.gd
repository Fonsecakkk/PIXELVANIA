extends Area2D
class_name doorcomponent_2

var _player_ref: Character = null

@export_category("Variables")
@export var _teleport_position: Vector2

@export_category("Objects")
@export var _animation: AnimationPlayer= null

func _on_body_entered(_body) -> void:
	if _body is Character:
		_player_ref = _body
		_animation.play("open_2")

func _on_animation_2_finished(_anim_name):
	if _anim_name == "open_2":
		_player_ref.global_position = _teleport_position
		_animation.play("close_2")

