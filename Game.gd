extends Node2D

enum {START, FINISH, PLAYING}
var game_state: int
var the_winner: String

func _ready():
	game_state = START

func _process(delta):
	if game_state == START:
		$Black/CollisionShape2D.disabled = false
		$White/CollisionShape2D.disabled = false
		$Black.position = $Black_start_point.position
		$White.position = $White_start_point.position
		$Black.visible = true
		$White.visible = true
		$Black.reset_speed()
		$White.reset_speed()
		$HUD.message("Space to Start")
		$HUD.win_message("")
		$HUD.visible_game(true)
		if Input.is_action_just_pressed("ui_select"):
			$Select_sound.play()
			game_state = PLAYING
			$HUD.count_down_start()
			$HUD.message("")
	elif game_state == PLAYING:
		$HUD.visible_game(false)
	elif game_state == FINISH:
		$HUD.count_down_stop()
		if the_winner == "Black":
			$HUD.change_all_message_color(Color(0,0,0,1))
			$HUD.message("Tap to restart")
			$HUD.win_message("BLACK WIN")
		elif the_winner == "White":
			$HUD.change_all_message_color(Color(1,1,1,1))
			$HUD.message("Tap to restart")
			$HUD.win_message("WHITE WIN")
		if Input.is_action_just_pressed("ui_select"):
			$Select_sound.play()
			game_state = START

func _on_HUD_exchange():
	if game_state == PLAYING:
		$Change_sound.play()
		if $Black:
			$Black.exchange()
		if $White:
			$White.exchange()

func _on_catch_up(winner):
	if game_state == PLAYING:
		game_state = FINISH
		the_winner = winner
