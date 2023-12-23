extends Node2D


signal targets_gone
signal target_deleted


const _REQUIRED_MATCHES : int = 3
const _MOVE_DOWN_AMOUNT : int = 75

var _desired_type # Enum
var _num_markers := 0

@onready var _target_scene := preload("res://target/target.tscn")
@onready var _target_mover : RigidBody2D = $Net
@onready var _timer : Timer = $MoveDownTimer


func _ready() -> void:
	var children := get_children(false)
	for child in children:
		if is_instance_of(child, Marker2D):
			_num_markers += 1
	_make_targets_on_markers()


func _process(_delta) -> void:
	if get_tree().get_nodes_in_group("targets").size() ==0:
		_reset_to_beginning()
#		targets_gone.emit()


func handle_hit(ball : Ball, first_hit : Target) -> void:
	_desired_type = ball.type
	if first_hit.type == _desired_type:
		# Remove the target from its group ASAP
		first_hit.remove_from_group("targets")
		first_hit.call_deferred("queue_free")
		target_deleted.emit()
		SFX.play_match_sound()
	else:
		SFX.play_no_match_sound()
	# Delete the Ball last for processing order
	ball.delete_self()


func set_sprite_to_random_triangles(sprite :Sprite2D, desired_type : String) -> void:
	var texture_node := get_node("TriangleImages/" + desired_type + str(randi_range(1,4)))
	sprite.texture = texture_node.texture


func _reset_to_beginning() -> void:
	_target_mover.global_position = Vector2.ZERO
	_timer.start()
	_make_targets_on_markers()


func _make_targets_on_markers() -> void:
	for i in range(1,_num_markers+1):
		var target : Target = _target_scene.instantiate()
		var marker_node = get_node("TargetMarker" + str(i))
		target.global_position = marker_node.global_position
		call_deferred("add_child", target)


func _on_ball_stopper_body_entered(body) -> void:
	if is_instance_of(body, Ball):
		body.delete_self()
		SFX.play_no_match_sound()


func _on_move_down_timer_timeout() -> void:
	SFX.play_alarm_sound()
	var tween = create_tween()
	tween.tween_property(_target_mover, "modulate", Color("ff796d"), 1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(_request_move_down)


func _request_move_down() -> void:
	var tween = create_tween()
	tween.tween_property(_target_mover, "modulate", Color(1,1,1), .2)
	tween.tween_callback(_move_down)


func _move_down() -> void:
	for child in get_children():
		# Both Targets and the Target Mover are RigidiBodies
		if is_instance_of(child, RigidBody2D):
			var tween = create_tween()
			var target_x = child.global_position.x
			var target_y = child.global_position.y+_MOVE_DOWN_AMOUNT
			tween.tween_property(child, "global_position", Vector2(target_x, target_y), .25)
	_timer.start()
