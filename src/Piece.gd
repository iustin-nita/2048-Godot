extends Button

var value: int = 0
var nextValue: int = 0

onready var move_tween := $Tween

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup()

func _setup():
	modulate = Settings.color_schemes["default"][String(value)]
	if value > 0:
		text = String(value)
		nextValue = value * 2
	else:
		text = ""

func move(pos: Vector2):
	move_tween.interpolate_property(self, "rect_position", rect_position, pos, 0.5, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	move_tween.start()

func remove():
	queue_free()
