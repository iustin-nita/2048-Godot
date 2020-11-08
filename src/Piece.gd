extends Node2D

export var value: int = 0
export var nextValue: int = 0

onready var button = $Button

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup()


	pass # Replace with function body.

func _setup():
	var style = button.get_stylebox("normal")
#	var poly = Polygon2D.new()
#	poly.set_polygon(PoolVector2Array([Vector2(0, 0),
#								  Vector2(0, 128),
#								  Vector2(128, 128),
#								  Vector2(128, 0)
#								]))
#	poly.color = Settings.color_schemes["default"][String(value)]
#	add_child(poly)
	# check value, set up color, change label
	button.rect_size = Vector2(128, 128)
	style.bg_color = Settings.color_schemes["default"][String(value)]
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
