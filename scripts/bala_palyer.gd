extends Area2D



var velocidad = 2
var direccion = 1
var damage_enemigo1 = 50
var damage_enemigo2 = 30
var damage_enemigo3 = 40


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	$AnimationPlayer.play("flish")
	position.x += velocidad*direccion
	if direccion < 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	



func _on_body_entered(body):
	if body.is_in_group("enemigos"):
		body._Hit(damage_enemigo1)  # Llama a la función "dead" del cuerpo enemigo si está en el grupo "enemigos"
	
	elif body.is_in_group("enemigos2"):
		body._Hit(damage_enemigo2)
	
	elif body.is_in_group("enemigos3"):
		body._Hit(damage_enemigo3)
	elif body.is_in_group("terrenos"):
		queue_free()
