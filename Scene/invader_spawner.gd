extends Node2D
# aula do dia 04/03 (possivel slide 1.7 e 1.8);

#aq nos iremos setar o comportamento dos inimigos em tela;
class_name InvaderSpawner

#aq definimos as posições dos inimigos;

const ROWS = 5
const COLUMNS = 11
const HORIZONTAL_SPACING = 32
const VERTICAL_SPACING = 32
const INVADER_HEIGHT = 24
const START_Y_POSITION = -50
const INVADER_POSITION_X_INCREMENT = 10
const INVADER_POSITION_Y_INCREMENT = 20

# aq definimos a orientacao da movimentacao do inimigo;
var movement_direction = 1

# aq definimos o tempo q leva pro inimigo mexer;
@onready var time = $Timer
var invader_scene = preload("res://Scene/invader.tscn")

@onready var shot_timer = $ShotTime #aula 06/03/24 slide1.8
var invader_shot_scene = preload("res://Scene/invader_shot.tscn")


func _ready():
# aq agente invoca os inimigos q serão afetados por essa movimentacao;
	var invader_1_res = preload("res://Resource/invader_1.tres")
	var invader_2_res = preload("res://Resource/invader_2.tres")
	var invader_3_res = preload("res://Resource/invader_3.tres")
	var invader_config
	
# aq agente define as posições de cada invasor na tela
	for row in ROWS:
		if row == 0:
			invader_config = invader_1_res
		elif row == 1 || row == 2:
			invader_config = invader_2_res
		elif row == 3 || row == 4:
			invader_config = invader_3_res

# movimentacao do invader andando nas linhas;
		var row_width = (COLUMNS * invader_config.width * 3) + ((COLUMNS - 1) * HORIZONTAL_SPACING)
		var start_x =  (position.x - row_width) / 2

# movimentacao do invader nas colunas;
		for col in COLUMNS:
			var x = start_x + (col * invader_config.width * 3) + (col * HORIZONTAL_SPACING)
			var y = START_Y_POSITION + (row * INVADER_HEIGHT) + (row * VERTICAL_SPACING)
			var spawn_position = Vector2(x, y)

# como o nome diz vc chama a function pra spawnar o bicho;
			spawn_invader(invader_config, spawn_position)


func spawn_invader(invader_config, spawn_position: Vector2):

# .instanciate() = eu estou dizendo q nessa cena o invader sera colocado;
	var invader = invader_scene.instantiate() as Invader
	invader.config = invader_config
	invader.global_position = spawn_position
	add_child(invader)
	
	
	


# atualizacao de quanto tempo demora pra se mexer;
func _on_timer_timeout():
	position.x += movement_direction * INVADER_POSITION_X_INCREMENT
	


func _on_left_wall_area_entered(area):#aula 06/03/24 slide1.8
# aq nos vamos criar as colisões com as paredes criadas;
# mov_dir == -1: estamos indicando a direção q se espera o hit do invader(lembrando q no eixo y a esquerda é indicada pelo -1);
	if(movement_direction == -1):
# curiosidade q descobri sem querer: se vc mudar o += pra -= o invader vai pra cima;
		position.y += INVADER_POSITION_Y_INCREMENT
# vai mudar a direção do invader: -1(sentido original/esquerda) * -1(vamos considerar como sendo o motivo da mudança) == 1(direita);
		movement_direction *= -1

func _on_right_wall_area_entered(area):
	if(movement_direction == 1):
		position.y += INVADER_POSITION_Y_INCREMENT
# vai mudar a direção do invader: 1(sentido original/direita) * -1(vamos considerar como sendo o motivo da mudança) == -1(esquerda);
		movement_direction *=-1
	

func _on_shot_time_timeout():#aula 06/03/24 slide1.8
# aq nos estamos estabelecendo o disparos aleatorios dos invaders;

# eu tentei separar pra facilitar as futuras explicações, a linha de codigo original esta logo abaixo desse comentario, infelizmente os argumentos pos '.' como
# .filter, .map e .pick_ramndom n podem ficar em uma linha separada do antrerior; 
# var random_position = get_children().filter(func(child): return child as Invader).map(func(invader): return invader.global_position).pick_random()

# acredito q aq nos criamos uma pseudo (child) q existe mas n é exibida na tela da direita pq se refere a uma dos elementos empilhados;
#p.s: eu vou questionar ela depois se essa explicação ta correta;
	var random_position = get_children().filter(
		func(child): 
# como dito anteriormente eu torno indiretamente Invader uma child de invader_spawn;
# .map: de acordo com a documentação o ".map" é uma array q utiliza o metodo 'Callable' sua função é chamar os elementos presentes no
# invader e retornar eles na global_position de forma aleatoria(.pick_random());
			return child as Invader).map(
				func(invader): 
					return invader.global_position).pick_random()


# criação(instanciamento) do tiro;
	var invader_shot = invader_shot_scene.instantiate() as InvaderShot
	get_tree().root.add_child(invader_shot)
# indica q o invader estabelecido na global position irão atirar aleatoriamente;
	invader_shot.global_position = random_position
	


