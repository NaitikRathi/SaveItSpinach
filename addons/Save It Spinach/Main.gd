tool
extends EditorPlugin


func _enter_tree():
	 add_custom_type("Save It Spinach","Node", preload("res://addons/Save It Spinach/Node/Save_it_Spinach_Node.gd"), preload("res://addons/Save It Spinach/Node/Icon/Icon.png"))


func _exit_tree():
	remove_custom_type("Save It Spinach")
