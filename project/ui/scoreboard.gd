extends Control


var _score := EndCondition.final_score
var _displayed_score := _score

@onready var _score_label : Label = $Score


func _ready() -> void:
	increase_score_by(0)


func _process(_delta) -> void:
	_displayed_score = ceil(lerpf(_displayed_score, _score, .05))
	_score_label.text = "Score: %d" % (_displayed_score)


func increase_score_by(num : int) -> void:
	_score += num

func get_score() -> int:
	return _score
