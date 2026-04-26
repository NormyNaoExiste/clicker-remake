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
@onready var upgrade_1_level: Label = $ShopMenu/ShopUpgradeSlot1/Upgrade1Level
@onready var upgrade_2_level: Label = $ShopMenu/ShopUpgradeSlot2/Upgrade2Level
@onready var upgrade_3_level: Label = $ShopMenu/ShopUpgradeSlot3/Upgrade3Level

#options
@onready var options_screen: Panel = $OptionsScreen
@onready var options_panel: Panel = $OptionsScreen/Options
@onready var v_box_container: VBoxContainer = $OptionsScreen/Options/VBoxContainer
@onready var resumir: Button = $OptionsScreen/Options/VBoxContainer/Resumir
@onready var opcoes: Button = $OptionsScreen/Options/VBoxContainer/Opcoes
@onready var sair: Button = $OptionsScreen/Options/VBoxContainer/Sair
@onready var rich_text_label: RichTextLabel = $OptionsScreen/Options/RichTextLabel


var upgrades_disponiveis:Array = []
var upgrades

var shop:bool = false
var shop_slot1_comprado = false
var options:bool = false


var moedas:int = 0

var ganho:int = 1
var ganho_total:int:
	get :
		return (ganho*multiplicador)
var multiplicador:int = 1

func _ready() -> void:
	SaveManager.read()
	fadeAnim.play("fade_out")
	_carregar_upgrades()
	
	upgrades = upgrades_disponiveis
	
	#carregar textos
	shop_upgrade_slot_1.upgrade_text = "A Banana adiciona +1 por nível no seu clique"
	shop_upgrade_slot_1.upgrade_name = "Banana"
	shop_upgrade_slot_1.upgrade_price = upgrades[0].custo_base
	
	
	#shop_botoes
	buy_button.pressed.connect(_comprar_upgrades.bind(0))
	buy_button_2.pressed.connect(_comprar_upgrades.bind(1))
	

func _carregar_upgrades():
	
	var banana = UpgradeData.new()
	banana.nome = "Banana"
	banana.custo_base = 10
	banana.modificador = 1
	banana.tipo = "clique"
	
	
	var cubo = UpgradeData.new()
	cubo.nome = "Cubo"
	cubo.custo_base = 120
	cubo.modificador = 2
	cubo.tipo = "multiplicador"
	
	upgrades_disponiveis = [banana, cubo]

func _comprar_upgrades(indice: int):
	var upgrade = upgrades_disponiveis[indice]
	var custo = upgrade.custo_base * (upgrade.nivel + 1)
	
	var novo_custo = upgrade.custo_base * (upgrade.nivel + 1)
	
	if moedas >= custo:
		moedas -= custo
		upgrade.nivel += 1
		
		match upgrade.tipo:
			"clique":
				ganho += upgrade.modificador
				novo_custo = upgrade.custo_base * (upgrade.nivel + 1)
			"multiplicador":
				multiplicador *= upgrade.modificador
				custo = upgrade.custo_base * (upgrade.nivel * upgrade.nivel)
				novo_custo = upgrade.custo_base * (upgrade.nivel * 4)
		
		
		
		match indice:
			0:
				upgrade_1_level.text = str("LVL: ", upgrade.nivel)
				shop_upgrade_slot_1.upgrade_text = str(
					"Banana está dando: +", ganho, " por clique")
				shop_upgrade_slot_1.upgrade_price = novo_custo
				
			1:
				upgrade_2_level.text = str("LVL: ", upgrade.nivel)
				shop_upgrade_slot_2.upgrade_text = str(
					"Cubo está dando: x", upgrade.modificador, " ao seu clique"
				)
				shop_upgrade_slot_2.upgrade_price = novo_custo
				
		print("Sucesso")
	else:
		print("Moedas insuficientes")

func _atualizar_textos_shop():
	pass

func _init() -> void:
	shop = false
	options = false

func _process(_delta: float) -> void:
	moedasLabel.text = str("Moedas:", moedas)
	if !shop:
		shop_menu.hide()
	if !options:
		options_screen.hide()


func _on_bola_pressed() -> void:
	moedas += ganho_total


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


func _on_config_pressed() -> void:
	if !options:
		options_screen.show()
		options = true

func _on_resumir_pressed() -> void:
	if options:
		options_screen.hide()
		options = false
		print(upgrades_disponiveis)

func _on_sair_pressed() -> void:
	SaveManager.save(upgrades_disponiveis)
	fadeAnim.play("fade_in")
	await fadeAnim.animation_finished
	get_tree().change_scene_to_file("res://Cenas/menu_principal.tscn")
