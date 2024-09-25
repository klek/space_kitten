extends Label

@onready var stop_watch: stop_watch = $stop_watch

func _ready() -> void:
	stop_watch.reset()
	stop_watch.start()


func _process(delta: float) -> void:
	var current_time : date_time = stop_watch.get_time()
	text = ( str(current_time.minutes).pad_zeros(2) + ":" + 
			 str(current_time.seconds).pad_zeros(2) + ":" +
			 str(current_time.centesimal).pad_zeros(2) )
