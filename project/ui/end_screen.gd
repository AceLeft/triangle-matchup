extends Control


@onready var _won_label : Label = $WonLabel


func _ready() -> void:
	if EndCondition.won:
		Jukebox.play_win_song()
		_won_label.text = "You win!"
	else:
		Jukebox.play_lose_song()
		_won_label.text = "You lose!"


func _on_play_again_button_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://ui/main_menu.tscn")
