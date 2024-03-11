extends Node2D

#AULA 11/03/24;

@onready var spawn_timer = $SpawnTimer
var projectile_scene = preload("res://Scene/invader_shot.tscn")


func _ready():
	spawn_timer.setup_timer()

#aq eu estou mostrando ao programa q o UFO atira e de q cena esse tiro vem (invader_shoot);
func _on_spawn_timer_timeout():
	var projectile = projectile_scene.instantiate()
	var projectile_sprite = projectile.get_node("Sprite2D") as Sprite2D
# aq eu estou informando a cor do projetil;
	projectile_sprite.modulate = Color(0.62, 0.2, 0.2, 1)
	projectile.global_position = global_position
# lembrando q esse projectile éo mesmo usado no invader;
	get_tree().root.add_child(projectile)
	spawn_timer.setup_timer()
