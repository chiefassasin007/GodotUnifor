extends Area2D

class_name Player
#velocidade do player
@export var speed = 200 # slide 1.4
#movimentacao Vector2 = movimentacao dos personagens sobre os eixos X, Y
#p.s 3: existe um vector3(3D) e ele controla a movimentacao do personagem sobre os eixos X, Y, Z;
#p.s 4: existe um eixo vector4(4D) como o nome diz ele explora o conceito da 4 dimensao(4d) pode ser usado pra fazer algumas animacoes; 
#eixo: X(laterais: esquerda e direita:  `-1 e +1`), Y(alturas: cima "-1", baixo "+1"), 
#Z(profundidades: frente[0,0,-1], tras[0,0,1]) 
var direction = Vector2.ZERO # slide1.4;

#start de variaveis slide1.5: 
#bouding == delimitar;
var bouding_size_x 
var start_bound
var end_bound
var teste
#starta o elemento de colisoes (variavel que delimita o espaco de atuacao do player);
@onready var collistion_rect: CollisionShape2D = $CollisionShape2D #slide1.4
@onready var animation_player = $AnimationPlayer



func _ready(): #slide1.5
# novamente tamo delimitando o espaço de atuacao do player;
# shape == forma;
# get_rect(): cria um retangulo q delimita a ação do player, o size.x(tamanho.x) indica q o tamanho do retangulo está associado
# ao eixo x;
	bouding_size_x = collistion_rect.shape.get_rect().size.x
	var rect = get_viewport().get_visible_rect()

# usa o campo de visão da camera(area total) q esta no main como base 
# pra delimitar a area de acao do player;
	var camera = get_viewport().get_camera_2d()
	var camera_position = camera.position

# a divisão está limitando o tamanho q o player pode andar;
	start_bound = (bouding_size_x - rect.size.x) /2
	end_bound = (bouding_size_x + rect.size.x) /2
	
	
func _process(delta): #slide1.4;
# movimentacao do player;
# de acordo com a documentação do godot o get_axis é colocado quando 2 ações opostas(negativo e positivo)
# são utilizadas: no nosso caso a ação de mover pra direita(positiva) e a ação de mover pra esquerda(negativa);
	var input = Input.get_axis("move_left", "move_right")
	if input > 0 :
		direction = Vector2.RIGHT
	elif input < 0:
		direction = Vector2.LEFT
	else:
		direction = Vector2.ZERO
		
# a direcao x * a velocidade do objeto * a taxa de atualizacao;
	var delta_movement = direction.x * speed * delta #slide1.4;
	
	
	if(position.x + delta_movement < start_bound + bouding_size_x * transform.get_scale().x ||
	position.x + delta_movement > end_bound - bouding_size_x * transform.get_scale().x):
		return #slide1.5
	
	position.x += delta_movement #slide1.4;
	

# quando o player explodir execute o destroy animation
func on_player_destroyed():
	speed = 0
	animation_player.play("destroy")
