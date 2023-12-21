extends Control


@onready var _won_label : Label = $WonLabel
@onready var _score_label : Label = $ScoreLabel


func _ready() -> void:
	if EndCondition.won:
		Jukebox.play_win_song()
		_won_label.text = "You win!"
	else:
		Jukebox.play_lose_song()
		_won_label.text = "You lose!"
	
	_score_label.text = "Final Score: \n" + str(EndCondition.final_score)
	_tween_score_color()


func _tween_score_color() -> void:
	var tween = create_tween()
	var new_color = Color(randf(), randf(), randf())
	tween.tween_property(_score_label, "modulate", new_color, .5)
	tween.tween_callback(_tween_score_color)


func _on_play_again_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://ui/main_menu.tscn")
