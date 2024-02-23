extends CharacterBody2D


var velocidad_E_3 = 40
var direccion = 1
@export var bullet:PackedScene


func  _physics_process(_delta):
	$AnimationPlayer.play("run_E_3")
	
	if is_on_wall():
		direccion *=-1
	
	velocity.x = velocidad_E_3*direccion
	if velocity.x < 0:
		$AnimationPlayer.play("run_E_3")
		$Sprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimationPlayer.play("run_E_3")
		$Sprite2D.flip_h = false
	
	
	
	
	move_and_slide()
	detectores()
	detectar()

func  detectores():
	
	if $izquierda_E_3.is_colliding():
		var obj = $izquierda_E_3.get_collider()
		if obj.is_in_group("player"):
			$Sprite2D.flip_h = true
			$Marker2D.position.x = -25
		
			atack()
	
	if $derecha_E_3.is_colliding():
		var obj = $derecha_E_3.get_collider()
		if obj.is_in_group("player"):
			$Sprite2D.flip_h = false
			$Marker2D.position.x = 25
			
			atack()

func detectar():
	for i in get_slide_collision_count():
		var obj = get_slide_collision(i).get_collider()
		# Verificar si el objeto colisionado está en el grupo "player"
		if obj.is_in_group("player"):
			obj.damage(global_position.x) 




			
func atack():
	set_physics_process(false)
	velocity.x = 0
	$AnimationPlayer.play("atack_E_3")
	await $AnimationPlayer.animation_finished
	set_physics_process(true)


func shot():
	var new_bullet = bullet.instantiate()
	new_bullet.global_position = $Marker2D.global_position
	if $Sprite2D.flip_h:
		new_bullet.direccion = -1
	else:
		new_bullet.direccion = 1
	get_parent().add_child(new_bullet)


func _Hit(damage): 
	$ProgressBar.value -= damage
	if $ProgressBar.value <= 0:
		dead()
	


func dead():
	set_physics_process(false)  # Detiene el proceso físico del enemigo
	$AnimationPlayer.play("dead_E_3")  # Inicia la animación de muerte
	await $AnimationPlayer.animation_finished  # Espera hasta que la animación de muerte termine
	queue_free()  # Libera el nodo del enemigo
	get_parent().vida()



