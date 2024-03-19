extends Node
#AULA 18/03/24
# aq nos vamos estabelecer a pontuação do jogador ao destruir um invader;
class_name PointsCounter

signal on_points_increased(points: int)

#o valor inicial de pontos;
var points = 0
@onready var invader_spawner = $"../InvaderSpawner"

# quando for indentificada a destruição do invader nos camaremos a função points_increased;
func _ready():
	invader_spawner.invader_destroyed.emit(points_increased)

# declarando oq a função points increased faz, estabelecendo points_to_add como um parametro inteiro;
func points_increased(points_to_add: int):
	points += points_to_add
	on_points_increased.emit(points)
