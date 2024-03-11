extends Area2D

# p.s5: algum dos codigos que estao no slide sao diferentes dos codigos q a professora apresentou em sala
# ambas as versões estão corretas, contudo este codigo possui apenas coisas que foram faladas em sala
# por isso pode haver variações;

# o class_name está aq pq mais pra frente necessitaremos evocar o codigo referente ao laser para poder
# realizar interacoes entre ele e as demais partes do jogo;
class_name Laser #slide1.5;

# velocidade que o laser sai do player e viaja pela tela;
# o @export está aq apenas por capricho, mecher aq ou ir em Laser(Area 2d)> inspector> speed
# e alterar a velocidade da na mesma;
@export var speed = 600 

# aq vc está dizendo q o laser esta andando na posição y o '-=' indica q o laser esta andando para cima, 
# delta se refere amudança q o frame faz por segundo, 'speed * delta' é a atualização do movimento
# q o laser faz em frame per second(FPS);
func _process(delta): #slide1.5;
	position.y -= speed * delta
