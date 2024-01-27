extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var transition: ColorRect = $transition
@onready var loading_bar: TextureProgressBar = $"loading bar"
@onready var fade: ColorRect = $fade
@onready var bg_music: AudioStreamPlayer = $bg_music

func _ready() -> void:
	animation_player.play("fade")
	transition.visible = false

func _on_play_btn_pressed() -> void:
	transition.visible = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(transition, "material:shader_parameter/progress", 1, 2.0)
	tween.tween_callback(_load_level)

func _load_level() -> void:
	loading_bar.visible = true
	loading_bar.start_load()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade":
		animation_player.play("Menu")


func _on_bg_music_finished() -> void:
	bg_music.play()
