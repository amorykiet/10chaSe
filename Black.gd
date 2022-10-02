extends KinematicBody2D

enum {CHASE,ESCAPE}
var state : int
var velocity:= Vector2.ZERO

const escape_speed: int = 400
const chase_speed: int = 200
const WINDOW = OS.window_size

var speed: int
var chase_scale: int = 2
var escape_scale: int = 1

func _ready():
	state = ESCAPE

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("black_move_right"):
		velocity.x = 1
	elif Input.is_action_pressed("black_move_left"):
		velocity.x = -1
	if Input.is_action_pressed("black_move_up"):
		velocity.y = -1
	elif Input.is_action_pressed("black_move_down"):
		velocity.y = 1
	if state == CHASE:
		scale = Vector2.ONE* chase_scale
		speed = chase_speed
	elif state == ESCAPE:
		scale = Vector2.ONE* escape_scale
		speed = escape_speed
	move_and_slide(velocity*speed)
	if position.x > WINDOW.x:
		position.x = 0
	elif position.x < 0:
		position.x = WINDOW.x
	if position.y > WINDOW.y:
		position.y = 0
	elif position.y < 0:
		position.y = WINDOW.y
	var collision = get_last_slide_collision()
	if collision:
		if state == ESCAPE:
			queue_free()