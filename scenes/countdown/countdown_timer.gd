class_name countdown_timer
extends Node

## Triggers each secondsince the timer was started until countdown
## has ended. This includes the starting of the timer
## NOTE(klek): Does not trigger for the zero count
signal on_one_second_hit(remaining : int)
## Triggers when the countdown ends, ie when the countdown reaches
## zero
signal on_countdown_timeout()

## Sets your countdown value
## NOTE(klek): Specifying a different value for the start()-function
## call will overwrite this value
@export var countdown_value : int = 1

const DEFAULT_WAIT_TIME = 1.0

# The internal timer
var _timer : Timer = Timer.new()


func _ready() -> void:
	# Setup us the be always processing
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(_timer, true)
	_timer.stop()
	_timer.autostart = false
	_timer.one_shot = false
	_timer.wait_time = DEFAULT_WAIT_TIME
	_timer.timeout.connect(_on_countdown_timer_timeout)


## Starts the timer with the option to choose/change the countdown
## time
## NOTE(klek): Only supports 1 or higher integer values to start the
## countdown from
func start(countdown : int = 1 ) -> void:
	# Only support 1 or higher values to start countdown from
	if ( countdown < 1 ):
		countdown_value = 1
	else:
		countdown_value = countdown
	# Start the timer
	_timer.start(DEFAULT_WAIT_TIME)
	# Since the smallest countdown we support is 1 second
	# we can manually signal the on_one_second_hit signal here
	on_one_second_hit.emit(countdown_value)


## Callback for when the timer times out, which is every second
## due to the current configuration
func _on_countdown_timer_timeout() -> void:
	countdown_value -= 1
	if ( countdown_value > 0 ):
		on_one_second_hit.emit( countdown_value )
		return
	
	_timer.stop()
	on_countdown_timeout.emit()
