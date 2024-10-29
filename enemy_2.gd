extends CharacterBody2D

# Variables configurables
var velocidad = 80  # Velocidad de movimiento del enemigo
var direccion = Vector2.RIGHT  # Dirección inicial de movimiento (hacia la derecha)

# Variables configurables
var distancia_para_atacar = 150  # Distancia para realizar el ataque
# Referencia al jugador
var jugador

# Referencia al nodo AnimatedSprite2D para manejar la animación
@onready var animacion = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func _ready():
	# Iniciar la animación de caminar al comienzo
	animacion.play("caminar")
	# Asumimos que el jugador está en el nodo padre
	jugador = get_parent().get_node("Personaje")
	print("Valor de jugador: ", jugador)

func _process(delta):
	
	if jugador:
		comportamiento_enemigo(delta)


func comportamiento_enemigo(delta):
	# Calcula la distancia entre el enemigo y el jugador
	var distancia = position.distance_to(jugador.position)
	print("Valor de distancia: ", distancia)
	# Si el jugador está en rango de ataque, realiza el ataque
	if distancia < distancia_para_atacar:
		if animacion.animation != "atacar":
			animacion.play("atacar")
			$growl.play()
		velocity = Vector2.ZERO  # Detener cualquier movimiento residual
	else:
		if distancia > distancia_para_atacar:
			caminar(delta) 
			
			animacion.play("caminar")
			

func caminar(delta):
	# Mueve al enemigo en la dirección especificada
	velocity.x = direccion.x * velocidad
	
	move_and_slide()
