extends CanvasLayer
signal exchange


func count_down_start():
	$UI/Count_down/Timer.start()

func count_down_stop():
	$UI/Count_down/Timer.stop()

func message(mess: String):
	$"%Message".text = mess

func visible_game(visible_: bool):
	$UI/Game_name.visible = visible_
	$UI/Count_down.visible = not visible_
	
func win_message(mess: String):
	$"%Win_message".text = mess


func change_all_message_color(color : Color):
	$"%Message".modulate = color
	$"%Win_message".modulate = color
	$UI/Game_name.modulate = color

func _on_Timer_timeout():
	emit_signal("exchange")
