extends CharacterBody2D

const max_vel = 500
var vel = 0
const max_angle = 0.04
var angle = 0
var direccio = Vector2(1, 1)
#var resolucio = get_tree().root.content_scale_size

func _ready():
	#position = Vector2(resolucio.x / 2, resolucio.y / 2)
	pass
	
func _process(delta):
	if Input.is_action_pressed("mou_dreta") and angle <= max_angle:
		angle += 0.001
		
	if Input.is_action_pressed("mou_esquerra") and angle >= max_angle * -1:
		angle -= 0.001
		
	if Input.is_action_pressed("accelerar") and vel <= max_vel:
		vel += 5
		
	if Input.is_action_pressed("accelerar") == false and vel > 0:
		vel -= 5
	
	direccio = direccio.rotated(angle)
	velocity = direccio * vel
	move_and_slide()

	rotation = direccio.angle() - PI / 2
