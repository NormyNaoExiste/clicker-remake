extends Control

@onready var moedasLabel: Label = $MoedasLabel
@onready var shop_menu: Control = $ShopMenu
@onready var fadeAnim: AnimationPlayer = $Fade/AnimationPlayer

#shop
@onready var buy_button: Button = $ShopMenu/ShopUpgradeSlot1/BuyButton
@onready var buy_button_2: Button = $ShopMenu/ShopUpgradeSlot2/BuyButton2
@onready var buy_button_3: Button = $ShopMenu/ShopUpgradeSlot3/BuyButton3
@onready var shop_upgrade_slot_1: Panel = $ShopMenu/ShopUpgradeSlot1
@onready var shop_upgrade_slot_2: Panel = $ShopMenu/ShopUpgradeSlot2
@onready var shop_upgrade_slot_3: Panel = $ShopMenu/ShopUpgradeSlot3


var upgrades_disponiveis:Array = []

var shop:bool = false
var shop_slot1_comprado = false

var moedas:int = 0
var ganho:int = 1


func _ready() -> void:
	fadeAnim.play("fade_out")
	_carregar_upgrades()
	
	#carregar textos
	shop_upgrade_slot_1.upgrade_text = "Banana"
	
	#shop_botoes
	buy_button.pressed.connect(_comprar_upgrades.bind(0))
	

func _carregar_upgrades():
	
	var banana = UpgradeData.new()
	banana.nome = "Banana"
	banana.custo_base = 10
	banana.modificador = 1
	banana.tipo = "clique"
	
	upgrades_disponiveis = [banana]

func _comprar_upgrades(indice: int):
	var upgrade = upgrades_disponiveis[indice]
	var custo = upgrade.custo_base * (upgrade.nivel + 1)
	
	if moedas >= custo:
		moedas -= custo
		upgrade.nivel += 1
		ganho += upgrade.modificador
		print("Sucesso")
	else:
		print("Moedas insuficientes")

func _atualizar_textos_shop():
	pass

func _init() -> void:
	shop = false

func _process(_delta: float) -> void:
	moedasLabel.text = str("Moedas:", moedas)
	if !shop:
		shop_menu.hide()
func _on_bola_pressed() -> void:
	moedas += ganho


func _on_shop_button_pressed() -> void:
	_atualizar_textos_shop()
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
