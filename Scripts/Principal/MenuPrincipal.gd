extends Control

@onready var fadeAnim: AnimationPlayer = $Fade/AnimationPlayer
@onready var timer: Timer = $Fade/Timer


@onready var options: Control = $Options


@onready var play_button: Button = $VBoxContainer/Play
@onready var options_button: Button = $VBoxContainer/Options

var opt:bool = false

func _ready() -> void:
	fadeAnim.play("fade_out")
	
	play_button.pressed.connect(_on_play_pressed)
	options_button.pressed.connect(_on_options_pressed)


func _on_options_pressed():
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	fadeAnim.play("fade_out")
	if opt == false:
		options.show()
		opt = true

func _on_play_pressed() -> void:
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	get_tree().change_scene_to_file("res://Cenas/jogo.tscn")


func _on_options_exit_pressed() -> void:
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	fadeAnim.play("fade_out")
	if opt == true:
		options.hide()
		opt = false


func _on_quit_pressed() -> void:
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	get_tree().quit()
