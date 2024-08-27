extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_W):
		position += Vector2(0, -1)
	if Input.is_key_pressed(KEY_S):
		position += Vector2(0, 1)
	if Input.is_key_pressed(KEY_A):
		position += Vector2(-1, 0)
	if Input.is_key_pressed(KEY_D):
		position += Vector2(1, 0)
