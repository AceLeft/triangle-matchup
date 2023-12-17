class_name Target
extends RigidBody2D


@onready var type
@onready var _ball_sprite : Sprite2D = $Ball


func _ready() -> void:
	# Only give a random color if it does not already have one
	if type == null:
		var chosen_color = randi() % Congruent.Types.size()
		type = Congruent.Types.find_key(chosen_color)
		Congruent.modulate_to_correct_color(_ball_sprite, chosen_color)


func set_color(color) -> void:
	type = color
	# Cannot remove $Ball because _ready() may not have been called yet
	Congruent.modulate_to_correct_color($Ball, Congruent.Types.get(color))


func _on_ball_stopper_body_entered(body):
	if is_instance_of(body, Ball):
		get_parent().handle_hit(body, self)

