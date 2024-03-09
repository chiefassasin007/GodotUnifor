extends CanvasLayer
#p.s1: como esse é a primeira pagina de codigo eu deixei algumas das descrições originais em ingles nela;
#p.s2: o ';' indica o fim do comentario se n tiver das 2 > 1: ou eu esqueci de botar ou o comentario continua em baixo;
# define no codigo as texturas usadas na tela inicial slide 1.4;
@onready var texture_rect_1 = %TextureRect1
@onready var label_1 = %Label1
@onready var texture_rect_2 = %TextureRect2
@onready var label_2 = %Label2
@onready var texture_rect_3 = %TextureRect3
@onready var label_3 = %Label3

#serve para tratar as texturas como sendo a mesma coisa; slide 1.4;
var control_array = []

# vai ser usado como contador para a animacao dos inimigos na tela inicial;
@onready var timer = $Timer #slide 1.4

# Called when the node enters the scene tree for the first time.
func _ready():
# serve para garantir q haja a animacao dos inimigos e seus pontos aparecendo na tela 
# a cada novo ciclo de tempo imagem1> pontuacao1> imagem2> pontuacao2> imagem3> pontuacao3;
	control_array = [texture_rect_1, label_1, texture_rect_2, label_2, texture_rect_3, label_3]

# garante q as imagens nao aparecam de uma vez na tela;
	for control in control_array:
		(control as Control).visible=false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): #tempo de mudanca por frame chamado DELTA;
	pass
#sem uso 04/03/24;

# ATENÇÃO: aq nós estamos dando uma função ao child node:"Timer" para criar essa função vc 
# deve ir em Timer(na aba Inspector)> node(botão direito)> connect;
# OBS: sempre verifique se existe ao lado esquerdo da onde fica o numero de linhas 
#uma setinha q aponta para uma caixa(ambos na cor verde);
func _on_timer_timeout():
#contorle do tempo para as animacoes da tela de menu e suas transições;
	var control = control_array.pop_front() as Control

# controla a aparicao (transição) da pontuacao;
	if control != null:
		control.visible = true
	else: 

# informa ao programa para interromper o processo de execução do timer. Basicamente vc está abrindo espaço na memoria;
		timer.stop()

# queue_free apaga todos os elementos da tela;
		timer.queue_free()

#move a tela para a main;
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scene/main.tscn")
