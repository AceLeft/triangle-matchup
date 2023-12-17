extends Node


@onready var _game_song : AudioStreamPlayer = get_node("GameSong")
@onready var _title_song : AudioStreamPlayer = get_node("TitleSong")
@onready var _win_song : AudioStreamPlayer = get_node("WinSong")
@onready var _lose_song : AudioStreamPlayer = get_node("LossSong")


func play_game_song() -> void:
	_stop_all_songs()
	_game_song.play()


func play_title_song() -> void:
	_stop_all_songs()
	_title_song.play()


func play_win_song() -> void:
	_stop_all_songs()
	_win_song.play()


func play_lose_song() -> void:
	_stop_all_songs()
	_lose_song.play()


func _stop_all_songs() -> void:
	for child in get_children():
		child.stop()
