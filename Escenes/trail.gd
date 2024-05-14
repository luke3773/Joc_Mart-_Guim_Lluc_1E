extends Node2D

@export var max_llargada = 20
@export var max_amplada = 3.0

var punts = []
var frame = 0

func _physics_process(delta):
	if frame % 3 == 0:
		punts.push_front(global_position)
		if punts.size() > max_llargada:
			punts.pop_back()
			
	frame += 1
	
	queue_redraw()
	
func _draw():
	if punts.size() < 2:
		return
		
	var antialias = false
	var color = Color(0,0,0,0)
	var mida = float(punts.size())
	var ajustat = PackedVector2Array()
	var colors = PackedColorArray()
	
	for i in range(mida):
		ajustat.append(punts[i] - global_position)
		color.a = lerp(1.0, 0.0, i/mida)
		colors.append(color)

	draw_set_transform(Vector2(0,0), -get_parent().rotation, Vector2(1,1))
	draw_polyline_colors(ajustat, colors, max_amplada, antialias)
