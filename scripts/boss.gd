extends Node2D


@export var enemigo3:PackedScene

@export var damage:int

var new_enemigo = null


func  _ready():
	
	$Timer.start()


func _process(delta):
	$Anim_boss.play("idle")
	if new_enemigo ==null:
		spawn_enemigo()



func spawn_enemigo():
	
	set_process(false)
	
	$Anim_boss.play("invok")
	await $Anim_boss.animation_finished
	
	$Anim_spawn.play("spawn")
	await $Anim_spawn.animation_finished
	
	new_enemigo = enemigo3.instantiate()
	new_enemigo.position = $spawn_enemigos.position
	add_child(new_enemigo)
	
	set_process(true)

func vida():
	$ProgressBar.value -= damage
	if $ProgressBar.value <=0:
		set_process(false)
		$Anim_boss.play("dead")
		await $Anim_boss.animation_finished
		$Anim_boss.visible = false
		$Anim_spawn.visible = false
