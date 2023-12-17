extends Node2D


signal targets_gone
signal move_down_requested


const _REQUIRED_MATCHES : int = 3
const _MOVE_DOWN_AMOUNT : int = 75


var _starting_target : Target
var _neighbors_to_search : Array[Area2D]
var _viable_options : Array[Target]
var _desired_color # Enum


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
	_set_variables(ball, first_hit)
	if first_hit.ball_color == _desired_color:
		_find_viable_options()
	_determine_match()


func _set_variables(ball : Ball, first_hit : Target) -> void:
	_starting_target = _replace_ball_with_target(ball)
	_neighbors_to_search = first_hit.get_neighbors()
	_viable_options = [_starting_target]
	_desired_color = _starting_target.ball_color


func _replace_ball_with_target(ball : Ball) -> Target:
	ball.set_velocity_to_zero()
	var new_target : Target = load("res://target/target.tscn").instantiate()
	new_target.set_color(ball.ball_color)
	call_deferred("add_child",new_target)
	new_target.call_deferred("set_global_position", ball.global_position)
	ball.call_deferred("queue_free")
	return new_target


func _find_viable_options() -> void:
	var i := 0
	while i < _neighbors_to_search.size():
		var target : Target = _neighbors_to_search[i].get_parent()
		if target.ball_color == _desired_color:
			_viable_options.append(target)
			var new_neighbors : Array[Area2D] = target.get_neighbors()
			for neighbor in new_neighbors:
				var neighbor_not_already_searched := !_neighbors_to_search.has(neighbor)
				var neighbor_same_color : bool = neighbor.get_parent().ball_color == _desired_color
				if  neighbor_not_already_searched and neighbor_same_color:
					_neighbors_to_search.append(neighbor)
		i = i + 1


func _determine_match() -> void:
	if _viable_options.size() >= _REQUIRED_MATCHES:
		SFX.play_match_sound()
		for target in _viable_options:
			target.call_deferred("queue_free")
	else:
		SFX.play_no_match_sound()



func _on_ball_stopper_body_entered(body) -> void:
	if is_instance_of(body, Ball):
		_replace_ball_with_target(body)


func _on_move_down_timer_timeout() -> void:
	SFX.play_alarm_sound()
	var tween = create_tween()
	tween.tween_property($Net, "modulate", Color("ff796d"), 1).set_trans(Tween.TRANS_ELASTIC)
	tween.tween_callback(_request_move_down)


func _request_move_down() -> void:
	var tween = create_tween()
	tween.tween_property($Net, "modulate", Color(1,1,1), .2)
	move_down_requested.emit()
