extends CharacterBody2D

var velocidad = 100
var salto = 200
var gravedad = 400

func _physics_process(delta):
	
	
	velocity.y += gravedad*delta
	
	if Input.is_action_pressed("derecha"):
		
		velocity.x = velocidad
		
	elif Input.is_action_pressed("izquierda"):
		
		velocity.x = -velocidad
	
	else:
		
		velocity.x = 0
		
	if is_on_floor():	
		if  Input.is_action_just_pressed("Saltar"):
			velocity.y = -salto	

		
	move_and_slide()	
	
	
	animaciones()


func _input(event):
	if Input.is_action_just_pressed("atacar") and is_on_floor():
		set_physics_process(false)
		$AnimationPlayer.play("atack")
		await $AnimationPlayer.animation_finished
		set_physics_process(true)
	

func animaciones():
	if velocity.x > 0:
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("run")
		
	elif velocity.x < 0:
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("run")
		
	else:
		$AnimationPlayer.play("idle")	
		
	if velocity.y <0:
		$AnimationPlayer.play("jump")
	
	elif  velocity.y >0:
		$AnimationPlayer.play("fall")
		
	
