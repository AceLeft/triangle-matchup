extends Control


@onready var _label_box : ColorRect = $LabelBox
@onready var _instructions: Label = $LabelBox/HowToPlayText
@onready var _credits : Label = $LabelBox/CreditsText


func _ready() -> void:
	Jukebox.play_title_song()
	_tween_title_color()


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _tween_title_color() -> void:
	var tween = create_tween()
	var new_color = Color(randf(), randf(), randf())
	tween.tween_property($Title, "modulate", new_color, .75)
	tween.tween_callback(_tween_title_color)


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
