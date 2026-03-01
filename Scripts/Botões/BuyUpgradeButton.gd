extends Button

@onready var shop_dialogue: Label = $"../../ShopDialogue"
@onready var shop_upgrade_slot_1: Panel = $".."

const DIALOGUE_DEFAULT: String = "Dialogue box for upgrades"

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	shop_upgrade_slot_1._on_mouse_entered()
	shop_dialogue.text = str("Buy ", shop_upgrade_slot_1.upgrade_text)
func _on_mouse_exited():
	shop_dialogue.text = DIALOGUE_DEFAULT
	shop_upgrade_slot_1._on_mouse_exited()
