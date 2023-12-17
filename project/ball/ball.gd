class_name Ball
extends RigidBody2D


@onready var ball_color


func set_ball_color(chosen_color) -> void:
	ball_color = Colors.ColorNames.find_key(chosen_color)
	Colors.modulate_to_correct_color($Ball, chosen_color)
	$CPUParticles2D.modulate = $Ball.modulate


func set_velocity_to_zero() -> void:
	linear_velocity = Vector2(0,0)


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
