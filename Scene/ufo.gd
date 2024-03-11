extends Area2D

#AULA 11/03/24;
class_name Ufo

@export var speed = 50
@onready var sprite_2d = $Sprite2D
@onready var ufo_shooting = $UfoShooting
var explosion_texture = preload("res://Assets Space Invades/Ufo/Ufo-explosion.png")

# velocidade do "boss'
func _process(delta): 
	position.x -= speed * delta

# aq vamos progrmara a animação;
func _on_area_entered(area):
# se a area entrar em contato com Laser;
	if area is Laser:
# o UFO para de atirar
		ufo_shooting.queue_free()

# o UFO para de andar;
		speed = 0

# o UFO explode;
		sprite_2d.texture = explosion_texture

# a 'animação' rola por 1 segundo e depois some;
		await get_tree().create_timer(1).timeout
		queue_free()
