extends Area2D

class_name InvaderShot
@export var speed = 200


func _process(delta):
	position.y += speed * delta

