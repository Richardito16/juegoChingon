extends CharacterBody2D


var vel_enemigo2 = 30

func  _ready():
	pass

func  _physics_process(_delta):
	
	
	if !$abajo1.is_colliding():
		$Area2D.position.x = 23
		velocity.x = vel_enemigo2
		
	elif !$abajo2.is_colliding():
		$Area2D.position.x = -23
		velocity.x = -vel_enemigo2
	
	if velocity.x<0:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("run")
	elif velocity.x>0:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("run")
		
	move_and_slide()
	detectores()
	detectar()


func detectar():
	for i in get_slide_collision_count():
		var obj = get_slide_collision(i).get_collider()
		# Verificar si el objeto colisionado está en el grupo "player"
		if obj.is_in_group("player"):
			obj.damage(global_position.x) 




func  detectores():
	
	if $izquierda.is_colliding():
		var obj = $izquierda.get_collider()
		if obj.is_in_group("player"):
			$Sprite2D.flip_h = true
			$Area2D.position.x = -23
			atack()
	
	if $derecha.is_colliding():
		var obj = $derecha.get_collider()
		if obj.is_in_group("player"):
			$Sprite2D.flip_h = false
			$Area2D.position.x = 23
			atack()
			
func atack():
	velocity.x = 0
	$AnimationPlayer.play("atack")
	await $AnimationPlayer.animation_finished
	
	
	if $Sprite2D.flip_h:
	
		velocity.x = -vel_enemigo2
		
	else:
		
		velocity.x = vel_enemigo2

func _Hit(damage): 
	$ProgressBar.value -= damage
	if $ProgressBar.value <= 0:
		dead()
	


func dead():
	set_physics_process(false)  # Detiene el proceso físico del enemigo
	$AnimationPlayer.play("dead")  # Inicia la animación de muerte
	await $AnimationPlayer.animation_finished  # Espera hasta que la animación de muerte termine
	queue_free()  # Libera el nodo del enemigo

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.damage(global_position.x)# Replace with function body.
