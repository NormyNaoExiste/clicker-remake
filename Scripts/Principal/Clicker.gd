extends Control

@onready var moedasLabel: Label = $MoedasLabel
@onready var shop_menu: Control = $ShopMenu
@onready var fadeAnim: AnimationPlayer = $Fade/AnimationPlayer

var shop:bool = false

var moedas:int = 0
var ganho:int = 1

func _init() -> void:
	shop = false

func _process(_delta: float) -> void:
	moedasLabel.text = str("Moedas:", moedas)
	if !shop:
		shop_menu.hide()
func _on_bola_pressed() -> void:
	moedas += ganho


func _on_shop_button_pressed() -> void:
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	fadeAnim.play("fade_out")
	if !shop:
		shop_menu.visible = true
	shop = true


func _on_exit_shop_pressed() -> void:
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	fadeAnim.play("fade_out")
	if shop:
		shop_menu.hide()
	shop = false
