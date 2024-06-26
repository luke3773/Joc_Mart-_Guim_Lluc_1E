extends CharacterBody2D

const type = 'lladre'

const max_vel = 500
var acceleracio = 0
var max_acc = 200
var direccio = Vector2.RIGHT
var velocitat_angular = 0.07
var angle_dict = {Vector2.RIGHT : 'E', Vector2(1,1).normalized() : 'SE', Vector2.DOWN : 'S', Vector2(-1,1).normalized() : 'SW', Vector2.LEFT: 'W', Vector2(-1, -1).normalized() : 'NW', Vector2.UP : 'N', Vector2(1, -1) : 'NE'}
#var angle_dict = {(,): 'E', 7 * PI / 4 : 'SE', 3 * PI / 2 : 'S', 5 * PI / 4 : 'SW', PI : 'W', 3 * PI / 4 : 'NW', PI / 2 : 'N', PI / 4 : 'NE'}					
#var resolucio = get_tree().root.content_scale_size
var punt = Vector2(6219,-3847)
@export var areafinal : Node2D

func troba_animacio(angle, dict):
	
	for direccio in dict:
		if -PI/8 <= direccio.angle_to(Vector2.RIGHT.rotated(angle)) and direccio.angle_to(Vector2.RIGHT.rotated(angle)) <= PI/8:
			#print(rad_to_deg(direccio.angle_to(Vector2.RIGHT.rotated(angle))))
			#print(rad_to_deg(Vector2.RIGHT.rotated(angle).angle_to(direccio)))
			#print("%.2f   %.2f   %s" % [direccio.angle(), angle, dict[direccio]])
			return dict[direccio]

func _ready():
	#position = Vector2(resolucio.x / 2, resolucio.y / 2)
	pass
	
func _process(delta):
			
	if Input.is_action_pressed("dreta"):
		direccio = direccio.rotated(velocitat_angular)
		
	if Input.is_action_pressed("esquerra"):
		direccio = direccio.rotated(-velocitat_angular)
		
	if Input.is_action_pressed("accelerar") and velocity.length() <= max_vel:
		acceleracio = max_acc

	if Input.is_action_pressed("accelerar") == false and velocity.length() > 0:
		velocity = 0.95 * velocity
		acceleracio = 0
#		direccio.dot()
	
	if Input.is_action_pressed("frenar")  and velocity.length() > 0:
		acceleracio = -100

	#$Direccio.clear_points()
	#$Direccio.add_point(Vector2.ZERO)
	#$Direccio.add_point(direccio * 100)
	
	
	velocity += direccio.normalized() * acceleracio * delta
	move_and_slide()
	
	var sound_db = velocity.length() / max_vel * 9
	$acc.set_volume_db(sound_db)
	
	if $acc.is_playing() == false and velocity.length() > 0:
		$acc.play()
	
	var angle = direccio.angle()
	

	
	$animacio.play(troba_animacio(angle, angle_dict))
		
	$fletxa.look_at(punt)
	
	max_acc = 200




func _on_col·lisió_poli_body_entered(body):
	if body.type == 'policia':
		get_tree().change_scene_to_file("res://Escenes/EscenaFinalPoli.tscn")
