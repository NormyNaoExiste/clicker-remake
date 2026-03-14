extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var fadeAnim: AnimationPlayer = $Fade/AnimationPlayer

func _ready() -> void:
	animation_player.play("fade_in")
	await animation_player.animation_finished
	animation_player.play("smile")
	await animation_player.animation_finished
	animation_player.play("fade_out")
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")
