extends KinematicBody2D

var velocity = Vector2(0,0)
export var direction = -1
export var detectsCliffs = true
var speed = 50
const GRAVITY = 20

func _ready():
	
	if detectsCliffs:
		set_modulate(Color(1.5,0.6,1,1))
		
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
	$soundSquash.play()
	speed = 0
	disableCollisions()
	$Timer.start()
	body.bounce()

func _on_sidesChecker_body_entered(body):
	if body.name == "Attila":
		print("hit player side")
		disableCollisions()
		body.ouch(position.x)

func _on_bottomChecker_body_entered(body):
	if body.name == "Attila":
		print("hit player bottom")
		disableCollisions()
		body.ouch(position.x)

func disableCollisions():
	set_collision_mask_bit(0, false)
	set_collision_layer_bit(4, false)
	$topChecker.set_collision_mask_bit(0, false)
	$topChecker.set_collision_layer_bit(4, false)
	$sidesChecker.set_collision_mask_bit(0, false)
	$sidesChecker.set_collision_layer_bit(4, false)
	$bottomChecker.set_collision_mask_bit(0, false)
	$bottomChecker.set_collision_layer_bit(4, false)

func _on_Timer_timeout():
	queue_free()



