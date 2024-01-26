extends Node

enum Types {
	ADJ,
	HYP,
	OPP
}

func modulate_to_correct_color(sprite : Sprite2D, type_num : int) -> void:
	if type_num == Types.ADJ:
		sprite.set_modulate(Color("01b1e1"))
	if type_num == Types.HYP:
		sprite.set_modulate(Color("f6a000"))
	if type_num == Types.OPP:
		sprite.set_modulate(Color("9665d9"))

