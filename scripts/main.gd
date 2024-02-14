extends Node2D

var player 
var camera

func _ready():
	player = get_tree().get_nodes_in_group("player")[0]
	camera = get_tree().get_nodes_in_group("cameras")[0]
	
func  _process(_delta):
	if  player.global_position.x >0 and player.global_position.x <  460:
		camera.limit_left = 0
		camera.limit_right = 460 
	
	elif  player.global_position.x > 460 and player.global_position.x < 920:
		camera.limit_left = 460
		camera.limit_right = 920 
	elif  player.global_position.x > 920 and player.global_position.x < 1400:
		camera.limit_left = 920
		camera.limit_right = 1400	
	elif  player.global_position.x > 1400 and player.global_position.x < 1900:
		camera.limit_left = 1400
		camera.limit_right = 1900
