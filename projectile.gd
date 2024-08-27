extends Node2D

var speed = 3
var detection_radius = 100.0
var points = 0
var game_over_window: Popup

func _process(_delta):
	if Input.is_key_pressed(KEY_W):
		position += Vector2(0, -speed)
	if Input.is_key_pressed(KEY_S):
		position += Vector2(0, speed)
	if Input.is_key_pressed(KEY_A):
		position += Vector2(-speed, 0)
	if Input.is_key_pressed(KEY_D):
		position += Vector2(speed, 0)
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		speed = 5
	if position.x < 100:
		game_over("Tanque")
	#var alien_position = $alien.position 
	#var projectile_position = $Projectile.position  
	
	#var distance = projectile_position.distance_to(alien_position)
	
	#if distance <= detection_radius:
		#print("Projectile has impacted the alien")
		
		

func game_over(winner: String):
	get_tree().paused = true
	print(winner + " ha ganado el juego!")
	#var label = game_over_window.get_node("Label")  # Asegúrate de que el nodo Label sea hijo del WindowDialog
	#label.text = winner + " ha ganado el juego!"
	
	#game_over_window.popup_centered()
