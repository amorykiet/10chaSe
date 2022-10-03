extends Area2D

enum {CHASE,ESCAPE}
var state : int
var velocity:= Vector2.ZERO
var speed: int
var accelator: int
signal catch_up(winner)

const START_CHASE_SPEED: int = 300
const START_ESCAPE_SPEED: int = 650
const MAX_SPEED: int = 1500
const ACC_CHASE_SPEED: int = 60
const ACC_ESCAPE_SPEED: int = 10
var chase_scale: int = 2
var escape_scale: int = 1
const WINDOW = OS.window_size

func _ready():
	if name == "Black":
		speed = START_ESCAPE_SPEED
		state = ESCAPE
		scale = Vector2.ONE*escape_scale
	elif name == "White":
		speed = START_CHASE_SPEED
		state = CHASE
		scale = Vector2.ONE*chase_scale

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed(String(name).to_lower() + "_move_right"):
		velocity.x = 1
	elif Input.is_action_pressed(String(name).to_lower() + "_move_left"):
		velocity.x = -1
	if Input.is_action_pressed(String(name).to_lower() + "_move_up"):
		velocity.y = -1
	elif Input.is_action_pressed(String(name).to_lower() + "_move_down"):
		velocity.y = 1

	if state == CHASE:
		scale += Vector2.ONE*delta*30
		if scale > Vector2.ONE* chase_scale:
			scale = Vector2.ONE* chase_scale
		accelator = ACC_CHASE_SPEED
	elif state == ESCAPE:
		scale -= Vector2.ONE*delta*30
		if scale < Vector2.ONE* escape_scale:
			scale = Vector2.ONE* escape_scale
		accelator = ACC_ESCAPE_SPEED
	speed += accelator*delta
	if speed > MAX_SPEED:
		speed = MAX_SPEED
	
	position += velocity*speed*delta
	
	position.x = wrapf(position.x, 0, WINDOW.x)
	position.y = wrapf(position.y, 0, WINDOW.y)

func exchange():
	if state == ESCAPE:
		state = CHASE
		speed = START_CHASE_SPEED
	elif state == CHASE:
		state = ESCAPE
		speed = START_ESCAPE_SPEED

func _collide(area):
	if state == ESCAPE:
		$CollisionShape2D.set_deferred("disabled", true)
		visible = false
	elif state == CHASE:
		$Catch_up_sound.play()
		emit_signal("catch_up", name)

func reset_speed():
	if name == "Black":
		speed = START_ESCAPE_SPEED
		state = ESCAPE
		scale = Vector2.ONE*escape_scale
	elif name == "White":
		speed = START_CHASE_SPEED
		state = CHASE
		scale = Vector2.ONE*chase_scale
