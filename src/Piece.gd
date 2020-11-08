extends Button

var value: int = 0
var nextValue: int = 0


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
	else:
		text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
