extends Area2D

signal coin_collected

func _on_coin_body_entered(body):
	set_collision_mask_bit(0, false)
	$AnimationPlayer.play("coin_taken")
	emit_signal("coin_collected")
	$soundCoinCollect.play()
	
	
func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
