extends Button

@onready var shop_dialogue: Label = $"../../ShopDialogue"
@onready var shop_upgrade_slot_1: Panel = $".."



func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	shop_dialogue.show()
	shop_upgrade_slot_1._on_mouse_entered()
	shop_dialogue.text = str("Comprar ", shop_upgrade_slot_1.upgrade_name,
	 " por ", shop_upgrade_slot_1.upgrade_price)
func _on_mouse_exited():
	shop_dialogue.hide()
	shop_upgrade_slot_1._on_mouse_exited()
