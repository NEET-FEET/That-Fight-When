extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const SPEED = 350
const JUMP_HEIGHT = -500
const ATTACK_TIME = 0.15 #TODO: Decide if we're going to use frames or delta, I think the physics engine only supports delta so maybe stick with that? - AWK

var motion = Vector2()
var attacking = false
var attack_timer = 0
var left = false

export var PLAYER_ID = 1

var p_input = {}

func _ready():
	generate_inputs(PLAYER_ID)
	
func generate_inputs(id):
	p_input.left = "p%s_left" % id
	p_input.right = "p%s_right" % id
	p_input.up = "p%s_up" % id
	p_input.down = "p%s_down" % id
	p_input.attack = "p%s_attack" % id
	p_input.jump = "p%s_jump" % id
	
	print("Generated inputs %s for Player %s, Fighter %s" % [p_input, PLAYER_ID, name])
	
func _physics_process(delta):
	motion.y += GRAVITY
	
	if Input.is_action_pressed(p_input.right):
		motion.x = SPEED
		left = false
	elif Input.is_action_pressed(p_input.left):
		motion.x = -SPEED
		left = true
	else:
		motion.x = 0
	
	if Input.is_action_pressed(p_input.attack):
		get_node("Sprite").play("Attack")
		attack_timer = ATTACK_TIME
	else:
		if attack_timer <= 0:
			get_node("Sprite").play("Idle")
			attack_timer = 0
		else:
			attack_timer -= delta
	
	
	if is_on_floor():
		if Input.is_action_pressed(p_input.jump):
			motion.y = JUMP_HEIGHT
	
	get_node("Sprite").set_flip_h(left)
	motion = move_and_slide(motion, UP)