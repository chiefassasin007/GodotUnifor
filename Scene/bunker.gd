extends Area2D

@export var sprite: Sprite2D

# aq nos criamos o elemento q vai simular o dano do bunker quando associarmos ele no inspector de cada região
# do bunker nos podemos definir quantas animações ele terá;
@export var texture_array : Array[Texture2D]

#dano inicial;
var damage = 0

#dano maximo;
var MAX_DAMAGE = 3


#aq nos vamos definir como vai funcionar o dano e as animações de dano;
func _on_area_entered(area):

# quando o laser ou o invader shot entraem na area;
	if area is Laser || area is InvaderShot:

#limpe a area;
		area.queue_free()

# enquanto o dano for menor q o dano maximo;
		if damage < MAX_DAMAGE:
			damage += 1

# apos aumentar o dano va na testura e remova/troque a textura; 
			sprite.texture = texture_array[damage - 1]
		else:

# se o dano maximo for maior ou igual ao dano, limpe a area;
			queue_free()

# se o invader colidir com a area limpe ela completamente;
	if area is Invader:
		queue_free()
