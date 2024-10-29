extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const SHOOT_COOLDOWN = 0.5  # Tiempo entre disparos
var shoot_timer = 0  # Temporizador para controlar el tiempo entre disparos

var bullet_scene = preload("res://Personaje_main/ball.tscn")  # Cargar la escena del proyectil
var last_direction_right = true  # Variable para almacenar la última dirección

var is_walking = false

func animar():
	# Prioridad: si está disparando
	#if bullet_scene:
		#$AnimatedSprite2D.play("disparar")
		#return  # Evitar reproducir otras animaciones mientras dispara
	# Agacharse
	if Input.is_action_pressed("ui_down") and is_on_floor():
		$AnimatedSprite2D.play("agachar")
		return  # Evitar que otras animaciones se reproduzcan mientras se agacha
	# Movimiento horizontal y actualizar dirección
	if velocity.x > 0:
		last_direction_right = true
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("caminar")
	elif velocity.x < 0:
		last_direction_right = false
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("caminar")
	elif velocity.x == 0 and is_on_floor():
		$AnimatedSprite2D.play("parado")
	# Animación para salto y caída
	if velocity.y < 0:  # Saltando hacia arriba
		$AnimatedSprite2D.flip_h = not last_direction_right  # Voltear según la última dirección
		$AnimatedSprite2D.play("saltar")
	elif velocity.y > 0 and not is_on_floor():  # Cayendo
		$AnimatedSprite2D.flip_h = not last_direction_right  # Mantener la dirección durante la caída
		$AnimatedSprite2D.play("caer")


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$jumping.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	# Manejar movimiento
	if direction:
		velocity.x = direction * SPEED
		if not is_walking:  # Si no se está reproduciendo el sonido
			$running.play()  # Reproduce el sonido de caminar
			is_walking = true  # Marcar como caminando
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_walking:  # Si estaba caminando
			$running.stop()  # Detener el sonido de caminar
			is_walking = false  # Marcar como no caminando
	
	# Manejar Disparo
	shoot_timer -= delta
	if Input.is_action_just_pressed("ui_accept") and shoot_timer <= 0:
		shoot()
		shoot_timer = SHOOT_COOLDOWN  # Reiniciar el temporizador de disparo
	
	
	move_and_slide()
	animar()


func shoot():
	var bullet = bullet_scene.instantiate() # Instanciar el proyectil
	
	# Posicionar el proyectil en la posición del personaje
	if last_direction_right: 
		bullet.position = position + Vector2(0, 0)  # Posición a la derecha
	else:
		bullet.position = position + Vector2(0, 0)  # Posición a la izquierda
	
	# Reproducir el sonido de disparo
	$shot.play()

	# Configurar la dirección del proyectil
	if last_direction_right:
		bullet.direction = Vector2(1, 0)  # Dirección a la derecha
	else:
		bullet.direction = Vector2(-1, 0)  # Dirección a la izquierda

	# Añadir el proyectil a la escena
	get_parent().add_child(bullet)

	
	
# Reproducir la animación de disparo
	#is_shooting = true
	$AnimatedSprite2D.play("disparar")
	
	# Iniciar un temporizador para desactivar el estado de disparo
	#yield(get_tree().create_timer(0.3), "timeout") La duración de la animación de disparo
	#is_shooting = false  # Volver a las otras animaciones después de disparar
