extends CharacterBody2D

var vel_enemigo = 30  # Velocidad del enemigo
var vida
var ha_cambiado_posicion = false
func _ready():
	$AnimatedSprite2D.play("flight")  # Inicia la animación de vuelo al inicio
	
	# $AnimatedSprite2D.flip_h = true   Voltea el sprite horizontalmente

func _physics_process(_delta):
	
	# Verificar si el RayCast2D está colisionando con algo
	if $RayCast2D.is_colliding():
		var body = $RayCast2D.get_collider()
		# Verificar si el objeto colisionado está en el grupo "player"
		if body.is_in_group("player"):
			if not ha_cambiado_posicion:
				# Cambia la posición en x del enemigo
				global_position.x += -1  # Cambia este valor según sea necesario
				# Marca la variable ha_cambiado_posicion como verdadera para indicar que ya ha cambiado su posición en x
				ha_cambiado_posicion = true
			else:
				ha_cambiado_posicion = false
			$AnimatedSprite2D.play("atack")  # Inicia la animación de ataque
			#velocity.x = -vel_enemigo  # Establece la velocidad hacia la izquierda
		
	else:
		$AnimatedSprite2D.play("flight")  # Si no hay colisión, inicia la animación de vuelo
		
	move_and_slide()  # Aplica movimiento y detección de colisiones
	detectar()  # Llama a la función para detectar colisiones con el jugador

# Función para manejar la muerte del enemigo

func _Hit(damage):
	vel_enemigo = 10
	$ProgressBar.value -= damage
	if $ProgressBar.value <= 0:
		
		dead()
		
	


func dead():
	
	
	set_physics_process(false)  # Detiene el proceso físico del enemigo
	
	$AnimatedSprite2D.play("dead")  # Inicia la animación de muerte
	
	await $AnimatedSprite2D.animation_finished  # Espera hasta que la animación de muerte termine
	
	queue_free()  # Libera el nodo del enemigo

# Función para detectar colisiones con el jugador
func detectar():
	for i in get_slide_collision_count():
		var obj = get_slide_collision(i).get_collider()
		# Verificar si el objeto colisionado está en el grupo "player"
		if obj.is_in_group("player"):
			obj.damage(global_position.x)  # Llama a la función de daño del jugador y proporciona la posición global del enemigo
