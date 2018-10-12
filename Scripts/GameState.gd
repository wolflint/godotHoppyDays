extends Node2D

export var starting_lives = 3
export var coin_target = 5 # how many coins for an extra life

var coins = 0
var lives

onready var GUI = Global.GUI

func _ready():
	Global.GameState = self
	lives = starting_lives
	update_GUI()

func update_GUI():
	GUI.update_GUI(coins, lives)

func animate_GUI(animation):
	GUI.animate_GUI(animation)	

func hurt():
	lives -=1
	print("2")
	Global.Player.hurt()
	if lives < 0:
		end_game()
	animate_GUI("Hurt")	
	update_GUI()

func coin_up():
	coins += 1
	animate_GUI("CoinPulse")	
	update_GUI()
	var multiple_of_coin_target = (coins % coin_target) == 0
	if multiple_of_coin_target:
		life_up()

func life_up():
	#coins -= coin_target
	lives += 1
	animate_GUI("LifePulse")
	update_GUI()

func end_game():
	get_tree().change_scene(Global.GameOver)

func _on_Portal_body_entered(body):
	win_game()

func win_game():
	get_tree().change_scene(Global.Victory)
