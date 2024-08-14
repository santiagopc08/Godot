extends Sprite2D
var speed = 500
var direction = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Mueve la bala en la dirección dada
	position += direction * speed *delta
	# Destruye la bala si se sale de la pantalla
	if not get_viewport().get_visible_rect().has_point(position):
		queue_free()
