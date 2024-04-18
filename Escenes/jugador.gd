extends CharacterBody2D

const max_vel = 500
var vel = 0
const max_angle = 0.04
var angle = 0
var direccio = Vector2(1, 1).normalized()
var previous_angle = 0
var velocitat_angular = 0.001
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
	
	if angle < PI/2:
		
	
