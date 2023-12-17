extends Control


@onready var _label_box : ColorRect = $LabelBox
@onready var _instructions: Label = $LabelBox/HowToPlayText
@onready var _credits : Label = $LabelBox/CreditsText


func _ready() -> void:
	Jukebox.play_title_song()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_how_to_play_button_pressed() -> void:
	_label_box.visible = true
	_instructions.visible = true
	_credits.visible = false


func _on_credits_button_pressed() -> void:
	_label_box.visible = true
	_instructions.visible = false
	_credits.visible = true


func _on_ok_button_pressed() -> void:
	_label_box.visible = false
