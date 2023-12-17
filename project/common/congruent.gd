extends Node


enum Types {
	SSS,
	SAS,
	AAS,
	ASA,
	HL,
	NOT,
}


func modulate_to_correct_color(sprite : Sprite2D, type_num : int) -> void:
	if type_num == Types.SSS:
		sprite.set_modulate(Color("ff8426"))
	if type_num == Types.SAS:
		sprite.set_modulate(Color("68AED4"))
	if type_num == Types.AAS:
		sprite.set_modulate(Color("94216a"))
	if type_num == Types.ASA:
		sprite.set_modulate(Color("ff2674"))
	if type_num == Types.HL:
		sprite.set_modulate(Color("4a7d45"))
	if type_num == Types.NOT:
		sprite.set_modulate(Color("6a6f73"))
