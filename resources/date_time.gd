class_name date_time
extends Resource

const MAX_CENTESIMAL_COUNT = 100
const MAX_SECOND_COUNT = 60
const MAX_MINUTE_COUNT = 60
const MAX_HOUR_COUNT = 24

## Milliseconds
@export_range(0, MAX_CENTESIMAL_COUNT - 1) var centesimal : int = 0
## Seconds
@export_range(0, MAX_SECOND_COUNT - 1) var seconds : int = 0
## Minutes
@export_range(0, MAX_MINUTE_COUNT - 1) var minutes : int = 0
## Hours
@export_range(0, MAX_HOUR_COUNT - 1) var hours : int = 0
## Days
@export var days : int = 0


# Internal variable for keeping track of delta_time since last call
#var delta_seconds : float = 0.0
var delta_centesimal : float = 0.0

## Function to update the time
func update_time(delta : float ) -> void:
    # Update the internal variable with delta (in seconds) * 1000
    delta_centesimal += ( delta * MAX_CENTESIMAL_COUNT )
    # If the delta_centesimal is less than one, we return
    if ( delta_centesimal < 1.0 ):
        return

    # We have reached the treshold and need to update variables
    var delta_int_cent : int = delta_centesimal
    delta_centesimal -= delta_int_cent

    # Update individual variables, based on their order
    centesimal += delta_int_cent
    seconds += centesimal / MAX_CENTESIMAL_COUNT
    minutes += seconds / MAX_SECOND_COUNT
    hours += minutes / MAX_MINUTE_COUNT
    days += hours / MAX_HOUR_COUNT

    # Finally wrap each variable if the exceed their range
    centesimal = centesimal % MAX_CENTESIMAL_COUNT
    seconds = seconds % MAX_SECOND_COUNT
    minutes = minutes % MAX_MINUTE_COUNT
    hours = hours % MAX_HOUR_COUNT


## Function that resets the internal variables to zero
func reset_time() -> void:
    centesimal = 0
    seconds = 0
    minutes = 0
    hours = 0
    days = 0


#func convert_date_time_to_string_msc( val : date_time ) -> String:
func convert_date_time_to_string_msc( ) -> String:
    var text : String = ( str(minutes).pad_zeros(2) + ":" +
                          str(seconds).pad_zeros(2) + ":" +
                          str(centesimal).pad_zeros(2) )
    return text


func convert_date_time_to_string_hmsc( val : date_time ) -> String:
    var text : String = ( str(val.hours).pad_zeros(2) + ":" +
                          str(val.minutes).pad_zeros(2) + ":" +
                          str(val.seconds).pad_zeros(2) + ":" +
                          str(val.centesimal).pad_zeros(2) )
    return text
