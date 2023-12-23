extends Node2D


const _SCORE_INCREASE_AMOUNT := 200

@onready var _score_keeper = $Scoreboard
@onready var _quit_screen : ColorRect = $QuitScreen


func _ready() -> void:
	Jukebox.play_game_song()


func _on_target_manager_targets_gone() -> void:
	EndCondition.won = true
	_go_to_end_screen()


func _go_to_end_screen() -> void:
	EndCondition.final_score = _score_keeper.get_score()
	get_tree().call_deferred("change_scene_to_file", "res://ui/end_screen.tscn")


func _on_target_manager_target_deleted() -> void:
	_score_keeper.increase_score_by(_SCORE_INCREASE_AMOUNT)


func _on_fail_line_area_area_entered(area : Area2D) -> void:
	var area_parent = area.get_parent()
	if is_instance_of(area_parent, Target):
		EndCondition.won = false
		_go_to_end_screen()


func _on_quit_button_pressed() -> void:
	_quit_screen.show()
	get_tree().paused = true


func _on_return_button_pressed() -> void:
	_quit_screen.hide()
	get_tree().paused = false


func _on_exit_button_pressed() -> void:
	EndCondition.won = true
	get_tree().paused = false
	_go_to_end_screen()
