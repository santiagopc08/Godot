extends Area2D

const SPEED = 600  # Velocidad del proyectil
var direction = Vector2()  # Dirección del proyectil

func _ready():
	set_process(true)  # Inicia el procesamiento del proyectil

func _process(delta: float) -> void:
	position += direction * SPEED * delta  # Mueve el proyectil en la dirección definida
	
	# Eliminar el proyectil si está fuera de la pantalla
	if not get_viewport_rect().has_point(position):
		queue_free()

func _on_body_entered():
	queue_free()  # Eliminar el proyectil al colisionar con otro objeto
