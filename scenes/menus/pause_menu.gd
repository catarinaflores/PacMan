extends Control



func _on_resume_button_pressed():
	hide()
	await get_tree().create_timer(3.0).timeout
	get_tree().paused = false



func _on_main_menu_button_pressed():
	hide()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")



func _on_quit_button_pressed():
	get_tree().quit()
