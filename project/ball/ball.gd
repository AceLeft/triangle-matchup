class_name Ball
extends RigidBody2D


@onready var type


func set_type(chosen_type) -> void:
	type = Congruent.Types.find_key(chosen_type)
	Congruent.modulate_to_correct_color($Ball, chosen_type)
	$CPUParticles2D.modulate = $Ball.modulate


func set_velocity_to_zero() -> void:
	linear_velocity = Vector2(0,0)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
