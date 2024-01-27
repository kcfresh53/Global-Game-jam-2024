extends Control

func _on_mainmenu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_close_btn_pressed() -> void:
	visible = false
