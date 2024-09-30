class_name stop_watch
extends Node

# TODO(klek): Consider using this as an export instead?
@export var current_time : date_time

# Internal variable for keeping track of elapsed seconds
var total_time_elapsed_seconds : float = 0.0
var time
# Internal variable for keeping track of if the stopwatch is
# currently running or not
var is_stopped : bool = true


func _process(delta: float) -> void:
    if ( !is_stopped ):
        total_time_elapsed_seconds += delta
        # If the current_time is used, call update function
        if ( current_time != null ):
            current_time.update_time(delta)


## Stops the stopwatch
func stop() -> void:
    is_stopped = true


## Starts the stopwatch
func start() -> void:
    is_stopped = false


## Stops and resets the stopwatch
## NOTE(klek): Calling get_time*()-functions after this will return
## zero
func reset() -> void:
    is_stopped = true
    total_time_elapsed_seconds = 0.0
    if ( current_time != null ):
        current_time.reset_time()


## Restarts the stopwatch, by first resetting it then starting it
func restart() -> void:
    reset()
    start()


## Returns the total elapsed time since last reset, as a date_time
## class object
## NOTE(klek): This will return null if the user has not assigned
## a date_time object to the exported variable
func get_time() -> date_time:
    # Should I use duplicate here? When is the duplicate freed?
    return current_time.duplicate()


## Returns the total elapsed time in seconds since last reset
func get_time_seconds() -> float:
    return total_time_elapsed_seconds
