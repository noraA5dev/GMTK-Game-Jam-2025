extends Node
#DO NOT MOVE
#This is an autoload file, meaning it is always loaded and can be refernced/ accessed from anywhere in the project

signal fall_to_death

func trigger_fall_to_death():
	emit_signal("fall_to_death")
