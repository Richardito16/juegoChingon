extends CharacterBody2D

func _physics_process(_delta):
	
	$AnimationPlayer.play("NPC_idle")
