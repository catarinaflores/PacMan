extends Control

func _on_level_1_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_level_2_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_2.tscn")


func _on_level_3_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level_3.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
