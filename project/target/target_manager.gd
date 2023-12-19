extends Node2D


signal targets_gone
signal move_down_requested


const _REQUIRED_MATCHES : int = 3
const _MOVE_DOWN_AMOUNT : int = 75

var _desired_type # Enum


func _process(_delta) -> void:
	if get_tree().get_nodes_in_group("targets").size() ==0:
		targets_gone.emit()


func move_down() -> void:
	for child in get_children():
		if "global_position" in child:
			var tween = create_tween()
			var target_x = child.global_position.x
			var target_y = child.global_position.y+_MOVE_DOWN_AMOUNT
			tween.tween_property(child, "global_position", Vector2(target_x, target_y), .25)
	$MoveDownTimer.start()


func handle_hit(ball : Ball, first_hit : Target) -> void:
	_desired_type = ball.type
	ball.call_deferred("queue_free")
	if first_hit.type == _desired_type:
		first_hit.call_deferred("queue_free")
		SFX.play_match_sound()
	else:
		SFX.play_no_match_sound()


func set_sprite_to_random_triangles(sprite :Sprite2D, desired_type : String) -> void:
	var texture_node := get_node("TriangleImages/" + desired_type + str(randi_range(1,4)))
	sprite.texture = texture_node.texture


func _on_ball_stopper_body_entered(body) -> void:
	if is_instance_of(body, Ball):
		body.call_deferred("queue_free")
		SFX.play_no_match_sound()


func _on_move_down_timer_timeout() -> void:
	SFX.play_alarm_sound()
	var tween = create_tween()
	tween.tween_property($Net, "modulate", Color("ff796d"), 1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(_request_move_down)


func _request_move_down() -> void:
	var tween = create_tween()
	tween.tween_property($Net, "modulate", Color(1,1,1), .2)
	move_down_requested.emit()
