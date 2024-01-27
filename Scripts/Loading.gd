extends TextureProgressBar

@export var scene_to_change : PackedScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func start_load() -> void:
	animation_player.play("loading")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "loading":
		get_tree().change_scene_to_packed(scene_to_change)
