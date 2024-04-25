extends CharacterBody2D

const max_vel = 500
var vel = 0
var angle = 0
var direccio = Vector2(1, 1).normalized()
var previous_angle = 0
var velocitat_angular = 0.05
var angle_anterior = 0
var angle_dict = {Vector2(PI / 8, 15 * PI / 8) : 'E', Vector2(15 * PI / 8, 13 * PI / 8) : 'SE', Vector2(13 * PI / 8, 11 * PI / 8) : 'S', Vector2(11 * PI / 8, 9 * PI / 8) : 'SW', Vector2(9 * PI / 8, 7 * PI / 8) : 'W', Vector2(7 * PI / 8, 5 * PI / 8) : 'NW', Vector2(5 * PI / 8, 3 * PI / 8) : 'N', Vector2(3 * PI/8, PI / 8) : 'NE'}
#var angle_dict = {(,): 'E', 7 * PI / 4 : 'SE', 3 * PI / 2 : 'S', 5 * PI / 4 : 'SW', PI : 'W', 3 * PI / 4 : 'NW', PI / 2 : 'N', PI / 4 : 'NE'}					
#var resolucio = get_tree().root.content_scale_size

func troba_animacio(angle, dict):
	for item in dict:
		if item.x >= angle and item.y <= angle:
			return dict[item]

func _ready():
	#position = Vector2(resolucio.x / 2, resolucio.y / 2)
	pass
	
func _process(delta):
	if Input.is_action_pressed("dreta"):
		direccio = direccio.rotated(velocitat_angular)
		
	if Input.is_action_pressed("esquerra"):
		direccio = direccio.rotated(-velocitat_angular)
		
	if Input.is_action_pressed("accelerar") and vel <= max_vel:
		vel += 5
		
	if Input.is_action_pressed("accelerar") == false and vel > 0:
		vel -= 5
	
	velocity = direccio * vel
	move_and_slide()
	
	angle = direccio.angle()
	
	print(troba_animacio(angle, angle_dict))
	
	$animacio.play(troba_animacio(angle, angle_dict))
	
	#if find_similar(angle, angle_dict) == 'E':
		#$animacions/E.play()
		#
	#if find_similar(angle, angle_dict) == 'SE':
		#$animacions/SE.play()

	
