extends Button

func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		_on_playButton_pressed()

func _on_playButton_pressed():
	get_tree().change_scene("res://Level1.tscn")
