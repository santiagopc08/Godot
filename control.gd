extends Control

# Referencia al nodo de música de fondo
@onready var musica_fondo = $MusicaFondo  # Cambia la ruta si el nodo está en otro lugar

func _ready():
	# Inicia la música si no está en autoplay
	if not musica_fondo.playing:
		musica_fondo.play()

# Funciones opcionales para controlar la música
func detener_musica():
	musica_fondo.stop()

func pausar_musica():
	musica_fondo.stream_paused = true  # Pausa la música

func reanudar_musica():
	musica_fondo.stream_paused = false  # Reanuda la música
