class_name TriangleMaker
extends Node2D


enum types {
	ACUTE,
	OBTUSE,
	RIGHT_45,
	RIGHT_60,
	RIGHT,
	ISOSCELES,
	EQUILATERAL,
	SCALENE
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



class TriangleTypes:
	func set_line_points(_triangle : Triangle) -> void:
		push_warning("Using a function that should be filled out")


class Acute extends TriangleTypes:
	func set_line_points(triangle : Triangle) -> void:
		var base := 35
		var x1 := 10 + randi() % 10
		var y2 := 10 + randi() % 10
		var point1 := Vector2(x1,base)
		var point2 := Vector2(base, y2)
		
		triangle.set_up_lines(point1, point2)
		
