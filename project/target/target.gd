class_name Target
extends RigidBody2D


@onready var type
@onready var _sprite : Sprite2D = $Triangles


func _ready() -> void:
	# Only give a random type if it does not already have one
	if type == null:
		var chosen_type = randi() % Congruent.Types.size()
		type = Congruent.Types.find_key(chosen_type)
		get_parent().set_sprite_to_random_triangles(_sprite, type)
		$Triangles/TypeLabel.text = type




func _on_ball_stopper_body_entered(body):
	if is_instance_of(body, Ball):
		# It is the assumption that the Targets 
		# Are children of TargetManager
		get_parent().handle_hit(body, self)

