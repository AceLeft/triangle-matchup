class_name Ball
extends RigidBody2D

signal destroyed

@onready var type


func set_type(chosen_type) -> void:
	var _enum_keeper = Congruent
	if !EndCondition.using_congruency:
		_enum_keeper = Trig
	type = _enum_keeper.Types.find_key(chosen_type)
	_enum_keeper.modulate_to_correct_color($Ball, chosen_type)
	$CPUParticles2D.modulate = $Ball.modulate
	$TypeLabel.text = type


func set_velocity_to_zero() -> void:
	linear_velocity = Vector2(0,0)


func delete_self() -> void:
	destroyed.emit()
	call_deferred("queue_free")


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	call_deferred("queue_free")
