class_name Triangle
extends Node2D


@onready var _first : Line2D = get_node("O")
@onready var _second : Line2D = get_node("A")
@onready var _third : Line2D = get_node("H")

var _type : TriangleMaker.TriangleTypes

# Called when the node enters the scene tree for the first time.
func _ready():
	_type = TriangleMaker.Acute.new()
	_type.set_line_points(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_up_lines(pointA : Vector2, pointB : Vector2) -> void:
	_third.clear_points()
	_third.add_point(pointA, 0)
	_third.add_point(pointB, 1)
	
	_first.clear_points()
	_first.add_point(Vector2.ZERO, 1)
	_first.add_point(pointA, 0)
	
	_second.clear_points()
	_second.add_point(pointB, 0)
	_second.add_point(Vector2.ZERO, 1)
