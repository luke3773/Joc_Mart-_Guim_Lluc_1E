extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$camera_multiple.add_target($lladre)
	$camera_multiple.add_target($policia)
	
	var f = $MapaDefinitiu/mapa.get_used_rect()
	$camera_multiple.limit_left = f.position.x * $MapaDefinitiu/mapa.tile_set.tile_size.x
	$camera_multiple.limit_right = f.end.x * $MapaDefinitiu/mapa.tile_set.tile_size.x
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $lladre/VisibleOnScreenNotifier2D.is_on_screen() == false:
		get_tree().change_scene_to_file("res://Escenes/EscenaFinalLladre.tscn")
	
