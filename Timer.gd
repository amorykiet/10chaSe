extends Timer

func _process(delta):
	$Time_left.text = String(int(time_left))
