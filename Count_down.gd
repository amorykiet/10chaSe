extends HBoxContainer

func _physics_process(delta):
	$Second.text = "%d" % $Timer.time_left
	$Dsecond.text = "%2d" % (fmod($Timer.time_left,1)*60)


func _on_Timer_timeout():
	if modulate == Color(0,0,0,1):
		modulate = Color(1,1,1,1)
	elif modulate == Color(1,1,1,1):
		modulate = Color(0,0,0,1)
