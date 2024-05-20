extends CharacterBody2D
class_name Character

var _state_machine
var is_dead: bool = false
var _is_attacking: bool = false

@export_category("Variables")
@export var _move_speed:float = 68.0

@export var _friction: float = 0.2
@export var _acceleration: float = 0.2

@export_category("Objects")
@export var _attack_timer: Timer = null 
@export var _animation_tree: AnimationTree = null

@export var bullet_node: PackedScene


func _ready() -> void:
	_state_machine = _animation_tree["parameters/playback"]	

func _physics_process(_delta: float) -> void:
	if is_dead:
		return
		
	_move()
	_attack()
	_animate()
	move_and_slide()
	
	
#SISTEMA DE TIRO
func shoot():
	var bullet = bullet_node.instantiate()
 
	bullet.position = global_position
	bullet.direction = (get_global_mouse_position() - global_position).normalized()
	get_tree().current_scene.call_deferred("add_child",bullet)
 
func _input(event):
	if event.is_action("shoot"):
		shoot()
	



#MOVIMENTAÇAO DO PERSONAGEM
func _move() -> void:
	_animation_tree.active = true
	var _direction: Vector2= Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down") 
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction 
		_animation_tree["parameters/walk/blend_position"] = _direction 
		_animation_tree["parameters/attack/blend_position"] = _direction 
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	
	
#SISTEMA DE ATAQUE DO PERSONAGEM
func _attack() -> void:
	if Input.is_action_just_pressed("attack") and  not _is_attacking:
		set_physics_process(false)
		_attack_timer.start()
		_is_attacking = true
@onready var attack_sfx = $attack_sfx as AudioStreamPlayer

		
func _animate() -> void: 
	if _is_attacking:
		_state_machine.travel("attack")
		attack_sfx.play()
		return
		
	if velocity.length() > 10:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")
	
		
func _on_attack_timer_timeout() -> void:
	set_physics_process(true)
	_is_attacking = false
	
	
func _on_attack_area_body_entered(_body) -> void:
	if _body.is_in_group("enemy"):
		_body.update_health()
		


#MORTE
func die() -> void:
	is_dead = true
	_state_machine.travel("death")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Game Over/game_over.tscn")
	#get_tree().reload_current_scene()
	

#TELA DE MORTE
func gameOver() -> void:
	is_dead = true
	_state_machine.travel("death")
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://Game Over/game_over.tscn")
		
	
