class_name Launcher
extends Node2D


const _FORCE := 500
const _ROTATION_AMOUNT := PI/15
const _ROTATION_PER_SECOND := _ROTATION_AMOUNT * 5
const _LEFT_MAX_ANGLE := deg_to_rad(-87)
const _RIGHT_MAX_ANGLE := deg_to_rad(87)


var _next_color
var _launched := false
var _allowed_to_launch := true
var _ball : Ball
var _direction : Vector2
@onready var _cannon : Node2D = $Cannon
@onready var _spawn_timer : Timer = $SpawnTimer
@onready var _launch_animation : AnimatedSprite2D = $Cannon/Spring
@onready var _next_ball : Sprite2D = $NextBall


func _ready() -> void:
	_launched = true
	_spawn_timer.start()
	_next_color = randi() % Colors.ColorNames.size()
	Colors.modulate_to_correct_color(_next_ball, _next_color)


func _process(delta : float) -> void:
	if !_launched and _allowed_to_launch:
		_cannon.rotation = clamp(_cannon.rotation,_LEFT_MAX_ANGLE , _RIGHT_MAX_ANGLE)
		_direction = Vector2(0,-1).rotated(_cannon.rotation)

		if Input.is_action_just_released("launch"):
			_launch_animation.play("launch")

		if Input.is_action_just_pressed("angle_down_mouse"):
			_cannon.rotate(-1*_ROTATION_AMOUNT)
		if Input.is_action_just_pressed("angle_up_mouse"):
			_cannon.rotate(_ROTATION_AMOUNT)

		if Input.is_action_pressed("angle_left_key"):
			_cannon.rotate(-1*_ROTATION_PER_SECOND*delta)
		if Input.is_action_pressed("angle_right_key"):
			_cannon.rotate(_ROTATION_PER_SECOND*delta)


func get_ball_number() -> int:
	var counter := 0
	for child in get_children():
		if is_instance_of(child, Ball):
			counter += 1
	return counter


func enable() -> void:
	_allowed_to_launch = true


func disable() -> void:
	_allowed_to_launch = false


func _make_new_ball() -> void:
	_ball = preload("res://ball/ball.tscn").instantiate()
	_ball.set_ball_color(_next_color)
	_launched = false
	call_deferred("add_child", _ball)
	Colors.modulate_to_correct_color($Cannon/Arrow, _next_color)


func _on_spawn_timer_timeout() -> void:
	_make_new_ball()
	_launched = false
	_next_color = _choose_available_color()
	Colors.modulate_to_correct_color(_next_ball, _next_color)


func _choose_available_color() -> int:
	var target_array = get_tree().get_nodes_in_group("targets")
	var random_color = "ORANGE"
	if target_array.size() > 0:
		random_color = target_array.pick_random().ball_color
	return Colors.ColorNames.get(random_color)


func _on_spring_animation_finished() -> void:
	_ball.apply_impulse(_direction * _FORCE)
	_launched = true
	_spawn_timer.start()
	SFX.play_launch_sound()
	_launch_animation.frame = 0
