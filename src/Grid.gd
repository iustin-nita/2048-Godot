extends Node2D
signal score_changed

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
var xStart := 32
var yStart := 400
var offset := 128
var firstPiece = true

export var pieceScene: PackedScene = preload("res://src/Piece.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	board = make_2d_array()
	generateBackground()
	generateNewPiece()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TouchControl_move(direction: Vector2) -> void:
	moveAllPieces(direction)
	pass # Replace with function body.


func _on_KeyboardControl_move(direction: Vector2) -> void:
	print('move keyboard direction', direction)
	moveAllPieces(direction)
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
	
func moveAllPieces(direction: Vector2):
	match direction:
		Vector2.UP:
			for i in width:
				for j in height - 1:
					if board[i][j] != null:
						movePiece(Vector2(i,j), Vector2.UP)
		Vector2.DOWN:
			for i in width:
				for j in range(height - 1, -1 ,-1):
					if board[i][j] != null:
						movePiece(Vector2(i,j), Vector2.DOWN)
		Vector2.LEFT:
			for i in range(width - 1, -1 ,-1):
				for j in height:
					if board[i][j] != null:
						movePiece(Vector2(i,j), Vector2.LEFT)
		Vector2.RIGHT:
			for i in width - 1:
				for j in height:
					if board[i][j] != null:
						movePiece(Vector2(i,j), Vector2.RIGHT)
		_:
			continue

func moveAndSetValue(currPos: Vector2, desiredPos: Vector2):
	var temp = board[currPos.x][currPos.y]
	temp.move(gridToPixel(Vector2(desiredPos.x, desiredPos.y)))
	board[currPos.x][currPos.y] = null
	board[desiredPos.x][desiredPos.y] = temp

func movePiece(piece: Vector2, direction: Vector2):
	# Store de piece
	var p = board[piece.x][piece.y]
	var value = p.value
	# Store the value of the next space
	var next_space = piece + direction
	# Store the value of that piece
	var next_value = board[next_space.x][next_space.y]
	# Iterate through the board, looking for a non-empty space
	# or the end of the board
	match direction:
		Vector2.UP:
			for i in range(next_space.y, height):
				var currentPiece = board[piece.x][i]
				# If it's the end of the bopard, and that spot is null:
				if i == height - 1 && currentPiece == null:
					# Move the piece there:
					moveAndSetValue(piece, Vector2(piece.x, height -1))
					break
				# If this spot is full, and the value isn't the same
				# then move to one before it:
				if currentPiece != null:
					if currentPiece.value != value:
						# Move to one before it:
						moveAndSetValue(piece, Vector2(i-1, piece.y))
						break
					# If the spot is full, and the falue is the same as the piece
					# Then destroy both, and make a new one from the next value
					if currentPiece.value == value:
						var nextPieceValue = currentPiece.nextValue
						removeAndClear(piece)
						removeAndClear(Vector2(piece.x, i))
						board[piece.x][piece.y] = null
#						board[i][piece.y].startTimer()
#						p.move(gridToPixel(Vector2(i, piece.y)))
#						p.startTimer()
						var new_piece = pieceScene.instance()
						new_piece.value = nextPieceValue
						add_child(new_piece)
						print('new Piece!')
						board[piece.x][i] = new_piece
						new_piece.rect_position = gridToPixel(Vector2(piece.x, i))
						emit_signal("score_changed", new_piece.value)
						break;
		Vector2.DOWN:
			for i in range(next_space.x, -1, -1):
				var currentPiece = board[i][piece.y]
				# If it's the end of the bopard, and that spot is null:
				if i == 0 && board[i][piece.y] == null:
					# Move the piece there:
					moveAndSetValue(piece, Vector2(0, piece.y))
					break
				# If this spot is full, and the value isn't the same
				# then move to one before it:
				if board[i][piece.y] != null:
					if board[i][piece.y].value != value:
						# Move to one before it:
						moveAndSetValue(p, Vector2(i-1, piece.y))
						break
					# If the spot is full, and the falue is the same as the piece
					# Then destroy both, and make a new one from the next value
					if board[i][piece.y].value == value:
						var nextPieceValue = board[i][piece.y].nextValue
						removeAndClear(piece)
						removeAndClear(Vector2(i, piece.y))
						board[piece.x][piece.y] = null
#						board[i][piece.y].startTimer()
#						p.move(gridToPixel(Vector2(i, piece.y)))
#						p.startTimer()
						var new_piece = pieceScene.instance()
						new_piece.value = nextPieceValue
						add_child(new_piece)
						print('new Piece!')
						board[i][piece.y] = new_piece
						new_piece.rect_position = gridToPixel(Vector2(i, piece.y))
						emit_signal("score_changed", new_piece.value)
						break;
		Vector2.LEFT:
			for i in range(next_space.x, -1, -1):
				var currentPiece = board[i][piece.y]
				# If it's the end of the bopard, and that spot is null:
				if i == 0 && board[i][piece.y] == null:
					# Move the piece there:
					moveAndSetValue(piece, Vector2(0, piece.y))
					break
				# If this spot is full, and the value isn't the same
				# then move to one before it:
				if board[i][piece.y] != null:
					if board[i][piece.y].value != value:
						# Move to one before it:
						moveAndSetValue(piece, Vector2(i-1, piece.y))
						break
					# If the spot is full, and the falue is the same as the piece
					# Then destroy both, and make a new one from the next value
					if board[i][piece.y].value == value:
						var nextPieceValue = board[i][piece.y].nextValue
						removeAndClear(piece)
						removeAndClear(Vector2(i, piece.y))
						board[piece.x][piece.y] = null
#						board[i][piece.y].startTimer()
#						p.move(gridToPixel(Vector2(i, piece.y)))
#						p.startTimer()
						var new_piece = pieceScene.instance()
						new_piece.value = nextPieceValue
						add_child(new_piece)
						print('new Piece!')
						board[i][piece.y] = new_piece
						new_piece.rect_position = gridToPixel(Vector2(i, piece.y))
						emit_signal("score_changed", new_piece.value)
						break;
		Vector2.RIGHT:
			for i in range(next_space.x, width):
				var currentPiece = board[i][piece.y]
				# If it's the end of the bopard, and that spot is null:
				if i == width - 1 && currentPiece == null:
					# Move the piece there:
					moveAndSetValue(piece, Vector2(width-1, piece.y))
					break
				# If this spot is full, and the value isn't the same
				# then move to one before it:
				if board[i][piece.y] != null:
					if board[i][piece.y].value != value:
						# Move to one before it:
						moveAndSetValue(piece, Vector2(i-1, piece.y))
						break
					# If the spot is full, and the falue is the same as the piece
					# Then destroy both, and make a new one from the next value
					if board[i][piece.y].value == value:
						var nextPieceValue = board[i][piece.y].nextValue
						removeAndClear(piece)
						removeAndClear(Vector2(i, piece.y))
						board[piece.x][piece.y] = null
#						board[i][piece.y].startTimer()
#						p.move(gridToPixel(Vector2(i, piece.y)))
#						p.startTimer()
						var new_piece = pieceScene.instance()
						new_piece.value = nextPieceValue
						add_child(new_piece)
						print('new Piece!')
						board[i][piece.y] = new_piece
						new_piece.rect_position = gridToPixel(Vector2(i, piece.y))
						emit_signal("score_changed", new_piece.value)
						break;
						
func removeAndClear(piece: Vector2):
	if board[piece.x][piece.y]:
		board[piece.x][piece.y].remove()
		board[piece.x][piece.y] = null
	else:
		print('no Piece to remove')

func generateNewPiece():
	if isBlankSpace():
		var piecesMade = 0
		while piecesMade < 2:
			print('while')
			var x = int(floor(rand_range(0, 4)))
			var y = int(floor(rand_range(0, 4)))
			if board[x][y] == null:
				var temp = pieceScene.instance()
				temp.value = generateStartingNumber()
				add_child(temp)
				board[x][y] = temp
				temp.rect_position = gridToPixel(Vector2(x, y))
				piecesMade += 1
				print('temp', temp)
	else:
		print("no more room")

func generateBackground():
	for i in width:
		for j in height:
			var temp = pieceScene.instance()
			add_child(temp)
			temp.rect_position = gridToPixel(Vector2(i,j))
	
func generateStartingNumber():
	if firstPiece:
		firstPiece = false
		return 2
	var temp = rand_range(0,100)
	if temp <= 75:
		return 2
	return 4
	
	
