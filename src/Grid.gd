extends Node2D

"""
The grid script functions to ONLY control functions of the grid.
Tese functions are creating pieces, finding blank spaces, or moving pieces
and deleting/replacing pieces.
"""
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var width := 4
var height := 4
var board := []
var xStart := 96
var yStart := 796
var offset := 128


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	board = make_2d_array()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TouchControl_move(direction: Vector2) -> void:
	pass # Replace with function body.


func _on_KeyboardControl_move(direction: Vector2) -> void:
	pass # Replace with function body.

func make_2d_array():
	var array = []
	for i in width:
		array.append([])
		for j in height:
			array[i].append(null)
	return array
			

func gridToPixel(gridPosition: Vector2):
	var newX = xStart + offset * gridPosition.x
	var newY = yStart + -offset * gridPosition.y
	return Vector2(newX, newY)

func pixelToGrid(pixelPosition: Vector2):
	var newX = round((pixelPosition.x - xStart) / offset)
	var newY = round((pixelPosition.y - yStart) / offset)
	return Vector2(newX, newY)

func isInGrid(gridPosition: Vector2):
	if gridPosition.x >= 0 && gridPosition.x < width:
		if gridPosition.y >= 0 && gridPosition.y < height:
			return true
	return false
	
func isBlankSpace():
	for i in width:
		for j in height:
			if board[i][j] == null:
				return true
	return false
	
	
	
	
	
	
	
