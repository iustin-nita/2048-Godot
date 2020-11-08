extends Node2D

signal move

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("down"):
		emit_signal("move", Vector2.DOWN)
	if Input.is_action_just_pressed("up"):
		emit_signal("move", Vector2.UP)
	if Input.is_action_just_pressed("left"):
		emit_signal("move", Vector2.LEFT)
	if Input.is_action_just_pressed("right"):
		emit_signal("move", Vector2.RIGHT)
