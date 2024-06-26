extends CharacterBody2D

const max_vel = 500
var vel = 0
var angle = 0
var direccio = Vector2.RIGHT
var previous_angle = 0
var velocitat_angular = 0.05
var angle_anterior = 0
var angle_dict = {Vector2.RIGHT : 'E', Vector2(1,1).normalized() : 'SE', Vector2.DOWN : 'S', Vector2(-1,1).normalized() : 'SW', Vector2.LEFT: 'W', Vector2(-1, -1).normalized() : 'NW', Vector2.UP : 'N', Vector2(1, -1) : 'NE'}
#var angle_dict = {(,): 'E', 7 * PI / 4 : 'SE', 3 * PI / 2 : 'S', 5 * PI / 4 : 'SW', PI : 'W', 3 * PI / 4 : 'NW', PI / 2 : 'N', PI / 4 : 'NE'}					
#var resolucio = get_tree().root.content_scale_size
var punt = Vector2(4, 5)

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
	direccio = look_at(get_tree().)
	
	#$Direccio.clear_points()
	#$Direccio.add_point(Vector2.ZERO)
	#$Direccio.add_point(direccio * 100)
	velocity = direccio * vel
	move_and_slide()
	
	angle = direccio.angle()
	

	
	$animacio.play(troba_animacio(angle, angle_dict))
