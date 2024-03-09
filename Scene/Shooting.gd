extends Node2D

#slide 1.5;
#p.s6: como eu disse no 'p.s' anterior, existem algumas modificações entre o slide e oq foi mostrado em
# sala, usar preload ou PackedScene da na mesma;

# aq nos vamos delimitar o numero de disparos do jogador;

#preload(): esta carregando o objeto q sera afetado por esse codigo, no caso o laser;
var laser_scene = preload("res://Scene/laser.tscn")
var can_player_shoot = true



func _input(event):
# aq eu estou criando e definido q o laser possui relacões com o codigo principal;
	if Input.is_action_just_pressed("shoot") && can_player_shoot:
		var laser = laser_scene.instantiate() as Laser
		get_tree().root.add_child(laser)

# seto a posição inicial do disparo do player;
		laser.global_position = get_parent().global_position - Vector2(0 , 20)

# enquanto o laser n atingir o bullet_catcher, o player fica impossibilitado de atirar;
		can_player_shoot = false
	
# quando indentifica o impacto ele pergunta a função _tree_exited oq fazer a seguir;
		laser.tree_exited.connect(_tree_exited)

# vai informar ao programa q o player pode atirar de novo;
func _tree_exited():
	can_player_shoot = true
