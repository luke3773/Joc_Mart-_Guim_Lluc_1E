extends Node2D

var max_powerups = 20


func collocar_powerups_a():
	
	for i in max_powerups:
		
		var powerup = $powerups/accelerador.duplicate()
		$powerups.add_child(powerup)
		var llista_punts : Array[Node] = Global.Punts_a.get_children()
		var nombre_punts = llista_punts.size()
		
		powerup.global_position = llista_punts[randi_range(0, nombre_punts-1)].global_position

#func collocar_powerups_f():
#	
#	for i in max_powerups:
#		
#		var powerup = $powerups/frenador.duplicate()
#		$powerups.add_child(powerup)
#		var llista_punts : Array[Node] = Global.Punts_f.get_children()
#		var nombre_punts = llista_punts.size()
#		
#		powerup.global_position = llista_punts[randi_range(0, nombre_punts-1)].global_position

	

func _ready():

		
	collocar_powerups_a()
#	collocar_powerups_f()
	
	$camera_multiple.add_target($lladre)
	$camera_multiple.add_target($policia)
	
	var f = $MapaDefinitiu/mapa.get_used_rect()
	$camera_multiple.limit_left = f.position.x * $MapaDefinitiu/mapa.tile_set.tile_size.x
	$camera_multiple.limit_right = f.end.x * $MapaDefinitiu/mapa.tile_set.tile_size.x
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $lladre/VisibleOnScreenNotifier2D.is_on_screen() == false:
		get_tree().change_scene_to_file("res://Escenes/EscenaFinalLladre.tscn")
	
