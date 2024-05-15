extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.type == 'lladre' or body.type == 'poli':
		body.velocity *= 1.5
		var llista_punts : Array[Node] = Global.Punts_a.get_children()
		var nombre_punts = llista_punts.size()
		
		global_position = llista_punts[randi_range(0, nombre_punts-1)].global_position
