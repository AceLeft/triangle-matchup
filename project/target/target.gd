class_name Target
extends RigidBody2D


@onready var ball_color
@onready var _ball_sprite : Sprite2D = $Ball


func _ready() -> void:
	# Only give a random color if it does not already have one
	if ball_color == null:
		var chosen_color = randi() % Colors.ColorNames.size()
		ball_color = Colors.ColorNames.find_key(chosen_color)
		Colors.modulate_to_correct_color(_ball_sprite, chosen_color)


func set_color(color) -> void:
	ball_color = color
	# Cannot remove $Ball because _ready() may not have been called yet
	Colors.modulate_to_correct_color($Ball, Colors.ColorNames.get(color))


func get_neighbors() -> Array[Area2D]:
	var touching_list : Array[Area2D] = $NeighborDetector.get_overlapping_areas()
	return touching_list


func _on_ball_stopper_body_entered(body):
	if is_instance_of(body, Ball):
		get_parent().handle_hit(body, self)

