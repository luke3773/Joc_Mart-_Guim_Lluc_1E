extends CharacterBody2D

const type = 'poli'

const max_vel = 500
var acceleracio = 0
var direccio = Vector2.RIGHT
var velocitat_angular = 0.07
var derrape = 0.1
var angle_dict = {Vector2.RIGHT : 'E', Vector2(1,1).normalized() : 'SE', Vector2.DOWN : 'S', Vector2(-1,1).normalized() : 'SW', Vector2.LEFT: 'W', Vector2(-1, -1).normalized() : 'NW', Vector2.UP : 'N', Vector2(1, -1) : 'NE'}
#var angle_dict = {(,): 'E', 7 * PI / 4 : 'SE', 3 * PI / 2 : 'S', 5 * PI / 4 : 'SW', PI : 'W', 3 * PI / 4 : 'NW', PI / 2 : 'N', PI / 4 : 'NE'}					
#var resolucio = get_tree().root.content_scale_size
@export var lladre: Node2D

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
	if Input.is_action_pressed("dreta_p"):
		direccio = direccio.rotated(velocitat_angular)
		
	if Input.is_action_pressed("esquerra_p"):
		direccio = direccio.rotated(-velocitat_angular)
	
	if velocity.angle() < direccio.angle() and Input.is_action_pressed("derrapar"):
		velocity = velocity.rotated(derrape)
	
	if velocity.angle() > direccio.angle() and Input.is_action_pressed("derrapar"):
		velocity = velocity.rotated(-derrape)
		
	if Input.is_action_pressed("accelerar_p") and velocity.length() <= max_vel:
		acceleracio = 200
		
	if Input.is_action_pressed("accelerar_p") == false and velocity.length() > 0:
		velocity = 0.98 * velocity
		acceleracio = 0
#		direccio.dot()
	
	if Input.is_action_pressed("frenar_p")  and velocity.length() > 0:
		acceleracio = -100
	
	#$Direccio.clear_points()
	#$Direccio.add_point(Vector2.ZERO)
	#$Direccio.add_point(direccio * 100)
	
	velocity += direccio.normalized() * acceleracio * delta
	move_and_slide()
	
	var sound_db = velocity.length() / max_vel * 10
	$acc_p.set_volume_db(sound_db)
	
	if $acc_p.is_playing() == false:
		$acc_p.play()
	
	var angle = direccio.angle()
	

	
	$animacio.play(troba_animacio(angle, angle_dict))
		
	$fletxa.look_at(lladre.global_position)


func _on_area_2d_area_entered(area):
	acceleracio = 350




func _on_ralentitzador_area_entered(area):
	acceleracio = -50
