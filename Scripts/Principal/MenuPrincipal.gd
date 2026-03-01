extends Control

@onready var fadeAnim: AnimationPlayer = $Fade/AnimationPlayer



func _on_play_pressed() -> void:
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	fadeAnim.play("fade_out")
	await fadeAnim.animation_finished
	get_tree().change_scene_to_file("res://Cenas/jogo.tscn")
