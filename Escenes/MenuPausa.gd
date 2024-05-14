extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	$Objectius2.visible = false
	$Endarrere.visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		visible = !visible
		get_tree().paused = !get_tree().paused
	if $Objectius2.visible == true:
		$Endarrere.visible = true

func _on_menu_principal_pressed():
	get_tree().change_scene_to_file("res://Escenes/UI inicial.gd")


func _on_sortir_pressed():
	get_tree().quit()


func _on_continua_pressed():
	visible = false
	get_tree().paused = false

func _on_objectius_pressed():
	$Objectius2.visible = true
	$Endarrere.visible = true
	$Continua.visible = false
	$Sortir.visible = false
	$GreyPanel.visible = false
	$Label3.visible = false
	$Objectius.visible = false
	

func _on_endarrere_pressed():
	$Endarrere.visible = false
	$Objectius2.visible = false
	$Continua.visible = true
	$Sortir.visible = true
	$GreyPanel.visible = true
	$Label3.visible = true
	$Objectius.visible = true
