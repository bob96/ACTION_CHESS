extends Area2D

var is_selected=false

func _ready():
	set_process_input(true)
	set_fixed_process(true)
func _input(event):
	pass


func _on_piece_mouse_enter():
	is_selected=true
	print("in the collision shape")

func _on_piece_mouse_exit():
	is_selected=false
	print("out the collisionn shape")



func _process(delta):
	pass

