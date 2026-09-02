extends Node2D

var angulo:= 0.0

@export var distancia := 120.0
@export var velocidade := 1.2


func _process(delta: float) -> void:
	angulo += velocidade * delta
	
	var upgrades := get_children()
	var quantidade := upgrades.size()
	
	if quantidade == 0:
		return
		
	for i in range(quantidade):
		
		var angulo_upgrades := angulo + (TAU / quantidade) * i
		
		upgrades[i].position = Vector2(
			cos(angulo_upgrades),
			sin(angulo_upgrades)
		) * distancia
