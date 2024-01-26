extends Node


enum Types {
	SSS,
	SAS,
	AAS,
	ASA,
	NOT,
}


func modulate_to_correct_color(sprite : Sprite2D, type_num : int) -> void:
	if type_num == Types.SSS:
		sprite.set_modulate(Color("01b1e1"))
	if type_num == Types.SAS:
		sprite.set_modulate(Color("f6a000"))
	if type_num == Types.AAS:
		sprite.set_modulate(Color("9665d9"))
	if type_num == Types.ASA:
		sprite.set_modulate(Color("f773a2"))
	if type_num == Types.NOT:
		sprite.set_modulate(Color("f4e8bf"))



