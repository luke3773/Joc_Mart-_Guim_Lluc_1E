extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$camera_multiple.add_target($lladre)
	$camera_multiple.add_target($policia)
	
	var r = %MapaDefinitiu.get_used_rect()
	$camera_multiple.limit_left = r.position.x * %MapaDefinitiu.tile_set.tile_size.x
	$camera_multiple.limit_right = r.end.x * %MapaDefinitiu.tile_set.tile_size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
