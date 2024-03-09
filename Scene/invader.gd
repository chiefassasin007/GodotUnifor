extends Area2D
# memsma cois do class laser;
# aq agente vai setar a animacao dos inimigos;
# slide1.6
class_name Invader

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

# posso estar enganado mas aq eu creio q seja pra indicar q o programa em questão está sendo utilizado por
# multiplas variantes de um mesmo elemento(invasor);
# resource == recurso, fonte;
var config: Resource

# seta a execução das animações no codigo;
func _ready():
	sprite_2d.texture = config.sprite
	animation_player.play((config.animation_name))

# _on_area_entered: seria algo como se indentificar algo(laser) faça;
func _on_area_entered(area):#aula 06/03/24 slide1.8
# aq nos estamos indicando a desturicao do invasor. area: se refere ao area2D; 
	if area is Laser:
		animation_player.play("destroy")
		area.queue_free()

# quando a animação de explosão chega ao fim ela é apagada;
func _on_animation_player_animation_finished(anim_name):#aula 06/03/24 slide1.8
	queue_free()
