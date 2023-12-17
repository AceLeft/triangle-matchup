extends Node2D


var _check_launcher := false

@onready var _launcher : Launcher = $Launcher


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
	get_tree().call_deferred("change_scene_to_file", "res://ui/end_screen.tscn")


func _on_fail_line_area_area_entered(_area) -> void:
	EndCondition.won = false
	get_tree().call_deferred("change_scene_to_file", "res://ui/end_screen.tscn")


func _on_target_manager_move_down_requested() -> void:
	_check_launcher = true
