extends Control

@onready var fadeAnim: AnimationPlayer = $Fade/AnimationPlayer
@onready var timer: Timer = $Fade/Timer



@onready var play_button: Button = $VBoxContainer/Play
@onready var options_button: Button = $VBoxContainer/Options



func _ready() -> void:

	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)


func _on_options_pressed():
	pass
func _on_play_pressed() -> void:
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	get_tree().change_scene_to_file("res://Cenas/jogo.tscn")
