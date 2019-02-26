extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const SPEED = 350
const JUMP_HEIGHT = -500
const ATTACK_TIME = 7

var motion = Vector2()
var attack = 0

func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
	else:
		motion.x = 0
	
	if Input.is_action_pressed("ui_select"):
		print("select")
		get_node("AnimatedSprite").play("attack")
		attack = ATTACK_TIME
	else:
		if attack == 0:
			get_node("AnimatedSprite").play("default")
		else:
			attack -= 1
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
	motion = move_and_slide(motion, UP)