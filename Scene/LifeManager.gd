extends Node
#AULA 18/03/24;

# nesse codigo nos iremos controlar a vida do player;
class_name LifeManager

#signal: o sinal é uma forma de atualizar algum tipo de informação q pode ou nao ser casual por exemplo:
# um drop de moedas, o uso de algum item de cura, o disparo de uma arma especial ou no nosso caso 
# a perca de vida do player;
signal life_lost(life_left: int)

# limite de vidas do player;
@export var lifes = 3

# aq nós estamos declarando uma variavel 'player' do tipo 'Player' e atribuindo ela a cena player 
# q está instanciada no main;
@onready var player: Player = $"../Player"
var player_scene = preload("res://Scene/player.tscn")

#aq nos estamos mostrando ao programa que quando ele detectar q houve a destruição do player ele deve acessar
# a função player_lifes para prosseguir com a tomada de decisão( se o player tem vidas ou n);
func _ready():
	(player as Player).player_destroyed.connect(player_lifes)
	
# aq nos vamos fazer o player perder suas vidas;
func player_lifes():
# quando ele for chamado deve tirar uma vida do player;
	lifes -= 1

# como citado na explicação do signal : aq nos estamos verificando a perca de vida do jogador;
	life_lost.emit(lifes)
	if lifes != 0:

# quando a verificação terminar e o player ainda possuir vidas restantes ele criara um novo player;
		var player = player_scene.instantiate() as Player

# esse novo player sera criado na posição inicial;
		player.global_position = Vector2(0, 302)

# aq nos estamos dizendo q esse novo player esta conectado ao player life e que caso ele seja destruido
# a função será executada novamente;
		player.player_destroyed.connect(player_lifes)

# aq nos estamos conectando o novo player na main;
		get_tree().root.add_child(player)
