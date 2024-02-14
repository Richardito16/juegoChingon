extends CharacterBody2D

# Variables para el control del movimiento y animaciones
var velocidad = 90  # Velocidad horizontal del personaje
var salto = 180  # Fuerza de salto del personaje
var gravedad = 400  # Valor de la gravedad aplicada al personaje
var hit = false  # Variable para controlar si el personaje ha sido golpeado

var isCrouching = false


var damage_enemigo1 = 50
var damage_enemigo2 = 30
var damage_enemigo3 = 40

@export var bala_palyer:PackedScene



# Proceso físico del personaje
func _physics_process(delta):
	
	# Aplicar gravedad al personaje
	velocity.y += gravedad * delta
	
	if !hit:
		# Controlar el movimiento horizontal
		if Input.is_action_pressed("derecha"):
			$Sprite2D.flip_h = false
			$detect.position.x = 50
			$marcado_range.position.x = 60
			velocity.x = velocidad
		elif Input.is_action_pressed("izquierda"):
			$Sprite2D.flip_h = true
			$detect.position.x = -50
			$marcado_range.position.x = -60
			velocity.x = -velocidad
		else:
			velocity.x = 0
		
		if Input.is_action_pressed("Abajo"):
			isCrouching = true
		else:
			isCrouching = false
		
		# Saltar si está en el suelo y se presiona la tecla correspondiente
		if is_on_floor() and Input.is_action_just_pressed("Saltar"):
			velocity.y = -salto
		
		# Actualizar las animaciones del personaje
		animaciones()
		
		# Detectar enemigos y aplicar daño si colisiona con alguno
		detectar_enemigo()
		
	# Aplicar movimiento y detección de colisiones
	move_and_slide()	
	
# Manejar eventos de entrada
func _input(_event):
	# Iniciar animación de ataque si se presiona la tecla y el personaje está en el suelo
	if Input.is_action_just_pressed("atacar") and is_on_floor():
		set_physics_process(false)  # Detener el proceso físico temporalmente
		$AnimationPlayer.play("atack")
		await $AnimationPlayer.animation_finished  # Esperar hasta que la animación de ataque termine
		set_physics_process(true)  # Reactivar el proceso físico
	
	elif Input.is_action_just_pressed("ataque_rango") and is_on_floor():
		set_physics_process(false)  # Detener el proceso físico temporalmente
		$AnimationPlayer.play("atack_range")
		await $AnimationPlayer.animation_finished  # Esperar hasta que la animación de ataque termine
		set_physics_process(true)  # Reactivar el proceso físico

# Gestionar las animaciones del personaje
func animaciones():
	
	if is_on_floor():
		if velocity.x > 0:
			$Sprite2D.flip_h = false
			$AnimationPlayer.play("run_p")
		
		elif velocity.x < 0:
			$Sprite2D.flip_h = true
			$AnimationPlayer.play("run_p")
			
		
		else:
			$AnimationPlayer.play("idle")	
		
		if isCrouching:
				$AnimationPlayer.play("down")
				velocity.x = 0
				
	else:
		if velocity.y < 0:
			
			$AnimationPlayer.play("jump")
			
			if Input.is_action_pressed("atacar") :
				
				# Ejecutar animación de ataque durante el salto
				$AnimationPlayer.play("atack_on_air")
			
			if velocity.x < 0:
				$Sprite2D.flip_h = true
				
				
		elif velocity.y > 0:
			if Input.is_action_pressed("atacar"):
				
				# Ejecutar animación de ataque durante el salto
				$AnimationPlayer.play("atack_on_air")
			else:
				$AnimationPlayer.play("fall")
			if velocity.x > 0:
				$Sprite2D.flip_h = false
# Función para manejar el daño al personaje





func damage(pos_enemyX):
	hit = true
	
	if global_position.x < pos_enemyX:
		$Sprite2D.flip_h = false
		velocity = Vector2(-50,-100)
	else:
		$Sprite2D.flip_h = true
		velocity = Vector2(50,-100)
	
	$AnimationPlayer.play("hit")
	await $AnimationPlayer.animation_finished
	velocity = Vector2.ZERO
	hit = false

# Función para detectar enemigos y aplicar daño si colisiona
func detectar_enemigo():
	for i in get_slide_collision_count():
		var obj = get_slide_collision(i).get_collider()
		if obj.is_in_group("enemigos"):
			damage(obj.global_position.x)	
		elif obj.is_in_group("enemigos2"):
			damage(obj.global_position.x)
		elif obj.is_in_group("enemigos3"):
			damage(obj.global_position.x)
# Función llamada cuando el cuerpo detecta una colisión con otro cuerpo




func _on_detect_body_entered(body): 
	if body.is_in_group("enemigos"):
		body._Hit(damage_enemigo1)  # Llama a la función "dead" del cuerpo enemigo si está en el grupo "enemigos"
	
	elif body.is_in_group("enemigos2"):
		body._Hit(damage_enemigo2)
	elif body.is_in_group("enemigos3"):
		body._Hit(damage_enemigo3)





func shot_range():
	var new_bullet = bala_palyer.instantiate()
	new_bullet.global_position = $marcado_range.global_position
	
	if $Sprite2D.flip_h:
		new_bullet.direccion = -1
	else:
		new_bullet.direccion = 1
	get_parent().add_child(new_bullet)
