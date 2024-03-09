extends Area2D
#slide1.5;

# aq vc está avisando q qlq interação com essa area o item devera ser deletado/apagado/ignorado pelo programa
func _on_area_entered(area):
	area.queue_free()
