extends KinematicBody2D

var velocity = Vector2(0,0)
export var direction = -1
export var detectsCliffs = true
var speed = 50
const GRAVITY = 20

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	
	$floorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floorChecker.enabled = detectsCliffs	
	

func _physics_process(delta):

	if is_on_wall() or not$floorChecker.is_colliding() and detectsCliffs and is_on_floor():
		direction *=-1
		$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h 
		$floorChecker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y += GRAVITY
	velocity.x = speed * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_topChecker_body_entered(body):
	$AnimatedSprite.play("squashed")
	speed = 0
	set_collision_mask_bit(0, false)
	set_collision_layer_bit(4, false)
	$sidesChecker.set_collision_mask_bit(0, false)
	$sidesChecker.set_collision_layer_bit(4, false)
	


func _on_sidesChecker_body_entered(body):
	print("hit player")
	get_tree().change_scene("res://Level1.tscn")
