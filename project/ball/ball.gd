class_name Ball
extends RigidBody2D

signal destroyed

@onready var type


func set_type(chosen_type) -> void:
	type = Congruent.Types.find_key(chosen_type)
	Congruent.modulate_to_correct_color($Ball, chosen_type)
	$CPUParticles2D.modulate = $Ball.modulate
	$TypeLabel.text = type


func set_velocity_to_zero() -> void:
	linear_velocity = Vector2(0,0)


func delete_self() -> void:
	destroyed.emit()
	call_deferred("queue_free")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
