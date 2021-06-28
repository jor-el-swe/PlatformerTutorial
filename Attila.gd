extends KinematicBody2D

var velocity = Vector2(0,0)


const SPEED = 300
const JUMP_SPEED = -700
const GRAVITY = 30
const REDUCED_GRAVITY = -10

func _physics_process(delta):

	
	var totalGravity = GRAVITY;
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		$Sprite.play("walk")
		$Sprite.flip_h = false
		
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("walk")
	
	else: 
		$Sprite.play("idle")
		

	if !is_on_floor():
		$Sprite.play("air")
	

	if Input.is_action_just_pressed("jump") and is_on_floor():
		$soundJump.play()
		velocity.y = JUMP_SPEED
		
	if Input.is_action_pressed("jump") and velocity.y < 0:
		totalGravity += REDUCED_GRAVITY
	elif velocity.y < 0:
		totalGravity -= REDUCED_GRAVITY*1.5
		
	if velocity.y > 1 and velocity.y < 500:
		
		velocity.y += 500
		
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.y += totalGravity
	velocity.x = lerp(velocity.x,0,0.2)
	

func _on_FallZone_body_entered(body):
	get_tree().change_scene("res://GameOver.tscn")

func bounce():
	velocity.y = -500

func ouch(var xPosition):
	set_collision_mask_bit(4, false)
	velocity.y = -500
	print("ouch")
	if position.x < xPosition:
		velocity.x = -1000
	elif position.x > xPosition:
		velocity.x = 1000
		
	set_modulate(Color(1,0.3,0.3,0.4))
	$Timer.start()
	Input.action_release("left")
	Input.action_release("right")

func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	get_tree().change_scene("res://GameOver.tscn")
