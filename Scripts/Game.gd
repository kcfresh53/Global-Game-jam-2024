extends Node

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var transition: ColorRect = $CanvasLayer/transition
@onready var fade: ColorRect = $CanvasLayer/fade
@onready var score_lbl: Label = %score_lbl
@onready var texture_progress_bar: TextureProgressBar = %TextureProgressBar
@onready var poptime_btn: Button = $CanvasLayer/Poptime_btn
@onready var laugh_particles: CPUParticles2D = $LaughParticles
@onready var background_music: AudioStreamPlayer2D = $BackgroundMusic
@onready var fx: AudioStreamPlayer2D = $fx
@onready var joke_player: AudioStreamPlayer2D = $jokePlayer
@onready var pause_menu: Control = $CanvasLayer/pause_menu

var fxplayed : bool

func _ready() -> void:
	pause_menu.visible = false
	transition.visible = true
	fade.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(fade, "color", Color.TRANSPARENT, 0.5)
	tween.tween_property(transition, "material:shader_parameter/progress", 0, 1)
	tween.tween_callback(hide_transition)

func hide_transition() -> void:
	transition.visible = false
	fade.visible = false
	background_music.playing = true


func _on_grid_progress_bar_update(value: int) -> void:
	texture_progress_bar.value = value


func _on_grid_score_updated(score: int) -> void:
	score_lbl.text = "Score: " + str(score)


func _on_grid_pop_time() -> void:
	if !fxplayed:
		fx.play()
		fxplayed = true
	animation_player.play("poptime")
	poptime_btn.visible = true


func _on_poptime_btn_pressed() -> void:
	poptime_btn.visible = false
	$Grid.reset_progress()
	laugh_particles.emitting = true
	fxplayed = false
	joke_player.playing_random = true


func _on_background_music_finished() -> void:
	background_music.play()


func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu.visible = true

