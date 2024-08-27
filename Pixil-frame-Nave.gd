extends Sprite2D

# Velocidad de movimiento en píxeles por segundo
var speed = 200
var mouse_position: Vector2
var direction_to_mouse: Vector2
var angle: float
# Prefab de la bala
@export var bullet_scene: PackedScene
var shoot_cooldown = 0.5
var shoot_timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Obtener la posición del ratón en relación al objeto
	mouse_position= get_viewport().get_mouse_position()
	# Calcular el ángulo hacia el ratón
	direction_to_mouse = (mouse_position - global_position).normalized()
	angle = direction_to_mouse.angle()
	# Rotar el objeto hacia el ratón
	rotation = angle
	# Obtener la entrada de movimiento
	var move_input = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		move_input.x +=1
	if Input.is_action_just_pressed("ui_left"):
		move_input.x -= 1
	if Input.is_action_just_pressed("ui_down"):
		move_input.y += 1
	if Input.is_action_just_pressed("ui_up"):
		move_input.y -= 1
		
	if position.x > 1100:
		game_over("Alien")
	
	 # Normalizar la entrada de movimiento y aplicar la velocidad
	move_input = move_input.normalized()*speed* delta
	
	 # Mover el objeto en la dirección en la que está mirando
	if move_input.length() > 0:
		var move_direction = move_input.rotated(rotation)
		position += move_direction
# Disparar la bala
	shoot_timer -= delta
	if Input.is_action_just_pressed("shoot") and shoot_timer <=0:
		shoot_bullet()
		shoot_timer = shoot_cooldown
	
func shoot_bullet():
	# Instanciar la bala
	var bullet = bullet_scene.instantiate() as Sprite2D
	get_tree().current_scene.add_child(bullet)
	
	# Configurar la dirección de la bala
	bullet.position = position
	bullet.direction= direction_to_mouse 


func game_over(winner: String):
	# Detén el juego
	get_tree().paused = true
	print(winner + " ha ganado el juego!")
	# Muestra quién ganó en la ventana emergente
	#var label = game_over_window.get_node("Label")  # Asegúrate de que el nodo Label sea hijo del WindowDialog
	#label.text = winner + " ha ganado el juego!"
	
	# Muestra la ventana emergente
	#game_over_window.popup_centered()
