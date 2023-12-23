extends Node2D


const _SCORE_INCREASE_AMOUNT := 200

var _check_launcher := false

@onready var _launcher : Launcher = $Launcher
@onready var _score_keeper = $Scoreboard


func _ready() -> void:
	Jukebox.play_game_song()


func _process(_delta) -> void:
	if _check_launcher:
		if get_tree().get_nodes_in_group("balls").size() > 1:
			_launcher.disable()
		else:
			$TargetManager.move_down()
			_launcher.enable()
			_check_launcher = false


func _on_target_manager_targets_gone() -> void:
	EndCondition.won = true
	_go_to_end_screen()


func _go_to_end_screen() -> void:
	EndCondition.final_score = _score_keeper.get_score()
	get_tree().call_deferred("change_scene_to_file", "res://ui/end_screen.tscn")


func _on_target_manager_move_down_requested() -> void:
	_check_launcher = true


func _on_target_manager_target_deleted() -> void:
	_score_keeper.increase_score_by(_SCORE_INCREASE_AMOUNT)


func _on_fail_line_area_area_entered(area : Area2D) -> void:
	var area_parent = area.get_parent()
	if is_instance_of(area_parent, Target):
		EndCondition.won = false
		_go_to_end_screen()
