extends CanvasLayer

var coins = 0
export var NO_COINS_TO_WIN = 6

func _ready():
	$Coins.text = String(coins)
	
func _physics_process(delta):
	if coins == NO_COINS_TO_WIN:
		get_tree().change_scene("res://Level1.tscn")


func _on_coin_collected():
	coins+=1
	_ready()
