extends CharacterBody2D

const max_vel = 500
var vel = 0
const max_angle = 0.04
var angle = 0
var direccio = Vector2(1, 1).normalized()
var previous_angle = 0
var velocitat_angular = 0.001
var angle_anterior = 0
var angle_dict = {Vector2(PI / 8, 15 * PI / 8) : 'E', Vector2(15 * PI / 8, 13 * PI / 8) : 'SE', Vector2(13 * PI / 8, 11 * PI / 8) : 'S', Vector2(11 * PI / 8, 9 * PI / 8) : 'SW', Vector2(9 * PI / 8, 7 * PI / 8) : 'W', Vector2(7 * PI / 8, 5 * PI / 8) : 'NW', Vector2(5 * PI / 8, 3 * PI / 8) : 'N', Vector2(3 * PI/8, PI / 8) : 'NE'}
					
#var resolucio = get_tree().root.content_scale_size

func _ready():
	#position = Vector2(resolucio.x / 2, resolucio.y / 2)
	previous_angle = angle
	
func _process(delta):
	if Input.is_action_pressed("dreta") and angle <= max_angle:
		direccio = direccio.rotated(velocitat_angular)
		
	if Input.is_action_pressed("esquerra") and angle >= max_angle * -1:
		direccio = direccio.rotated(-velocitat_angular)
		
	if Input.is_action_pressed("accelerar") and vel <= max_vel:
		vel += 5
		
	if Input.is_action_pressed("accelerar") == false and vel > 0:
		vel -= 5
	
	velocity = direccio * vel
	move_and_slide()

	var angle = direccio.angle()
	
	if angle_dict[angle_anterior] != angle_dict[angle]:
		$ani
		
	angle_anterior = angle
	
