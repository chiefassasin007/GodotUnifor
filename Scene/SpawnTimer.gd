extends Timer

#AULA 11/03/24;
class_name SpawnTimer

# aq nos vamos mexer no tempo de spawn de tudo relacionado ao ufo;
@export var min_timer = 5

@export var max_timer = 10


func _ready():
	setup_timer()

# aq nos iremos tratar o spawn do UFO como algo aleatorio dentro da faixa pre-estabelecida acima
func setup_timer():
	var random_timer=randf_range(min_timer,max_timer)

# o tempo de espera depende do random time;
	self.wait_time = random_timer
# apos liberar o UFO/tiro ele para a contagem de tempo;
	self.stop()

# reinicia o tempo (como se fosse um loop do tipo array);
	self.start()
