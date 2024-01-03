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


func set_sprite_to_random_triangles(sprite :Sprite2D, desired_type : String) -> void:
	# It is expected that the images follow these conventions:
	# 1. Begin with a lowercase version of their type
	# 2. The name ends in a number 1-4
	# 3. Is a .png
	# 4. They are located inside the target folder
	var path := "res://target/" + desired_type.to_lower() + str(randi_range(1,4)) + ".png"
	var image := Image.load_from_file(path)
	var texture := ImageTexture.create_from_image(image)
	sprite.texture = texture
	
