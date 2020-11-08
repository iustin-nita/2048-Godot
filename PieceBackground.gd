extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var poly = Polygon2D.new()
	poly.set_polygon(PoolVector2Array([Vector2(0, 0),
								  Vector2(0, 128),
								  Vector2(128, 128),
								  Vector2(128, 0)
								]))
	poly.color = Settings.color_schemes["default"]["2"]
	add_child(poly)



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
