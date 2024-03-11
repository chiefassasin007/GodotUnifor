extends Node2D

#AULA 11/03/24;

# vamos fazer o spawn do 'boss' 

@onready var spawn_timer = $SpawnTimer
var ufo_scene= preload("res://Scene/ufo.tscn")

func _ready():
# aq eu digo ao programa q spawn timer se refere ao codigo de SpawnTimer, setup_timer() foi criado em SpawnTimer;
	(spawn_timer as SpawnTimer).setup_timer()

func _on_spawn_timer_timeout():
	var ufo = ufo_scene.instantiate()
	ufo.global_position = position
# pego o conjunto de elementos de ufo e conecto a spawntimer;
	get_tree().root.add_child(ufo)
	spawn_timer.setup_timer()
