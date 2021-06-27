extends KinematicBody2D

var velocity = Vector2(0,0)
export var direction = -1
const ENEMY_SPEED = 50
const GRAVITY = 20

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
		
	

func _physics_process(delta):

	velocity.y += GRAVITY
	velocity.x = ENEMY_SPEED * direction
	
	move_and_slide(velocity)
