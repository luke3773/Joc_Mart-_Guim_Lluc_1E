extends CharacterBody2D

var vel = 200
var angle_dict = {Vector2.RIGHT : 'E', Vector2(1,1).normalized() : 'SE', Vector2.DOWN : 'S', Vector2(-1,1).normalized() : 'SW', Vector2.LEFT: 'W', Vector2(-1, -1).normalized() : 'NW', Vector2.UP : 'N', Vector2(1, -1) : 'NE'}

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D


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
	
func _physics_process(delta):

	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	
	velocity = dir * vel
	move_and_slide()
	
	
	var angle = dir.angle()
	#
#
	#
	$animacio.play(troba_animacio(angle, angle_dict))
	
func makepath():
	nav_agent.target_position = player.global_position
	
func _on_timer_timeout():
	makepath()
