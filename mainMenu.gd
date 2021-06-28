extends Button

func _physics_process(delta):
	if Input.is_action_just_pressed("jump"):
		_on_mainMenu_pressed()

func _on_mainMenu_pressed():
	get_tree().change_scene("res://TitleMenu.tscn")
