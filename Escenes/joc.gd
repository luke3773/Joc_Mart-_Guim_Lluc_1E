extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$camera_multiple.add_target($lladre)
	$camera_multiple.add_target($policia)
	
	var r = $mapa.get_used_rect()
	$camera_multiple.limit_left = r.position.x * $mapa.cell_size
	$camera_multiple.limit_left = r.end.x * $mapa.cell_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
