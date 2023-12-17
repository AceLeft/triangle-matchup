extends Node


enum ColorNames {
	ORANGE,
	BLUE,
	PURPLE,
	PINK,
}


func modulate_to_correct_color(sprite : Sprite2D, color_num : int) -> void:
	if color_num == ColorNames.ORANGE:
		sprite.set_modulate(Color("ff8426"))
	if color_num == ColorNames.BLUE:
		sprite.set_modulate(Color("68AED4"))
	if color_num == ColorNames.PURPLE:
		sprite.set_modulate(Color("94216a"))
	if color_num == ColorNames.PINK:
		sprite.set_modulate(Color("ff2674"))
