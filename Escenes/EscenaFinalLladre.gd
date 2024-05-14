extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Game_over.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://Escenes/joc.tscn")


func _on_sortir_pressed():
	get_tree().quit()
