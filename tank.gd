extends Node2D

var hasShot = false

func _process(_delta):
	if not hasShot:
		if Input.is_key_pressed(KEY_W):
			position += Vector2(0, -3)
		if Input.is_key_pressed(KEY_S):
			position += Vector2(0, 3)
		if Input.is_key_pressed(KEY_A):
			position += Vector2(-3, 0)
		if Input.is_key_pressed(KEY_D):
			position += Vector2(3, 0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		hasShot = true
