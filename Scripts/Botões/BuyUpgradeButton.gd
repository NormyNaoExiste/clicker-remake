extends Button

@onready var shop_dialogue: Label = $"../../ShopDialogue"
const DIALOGUE_DEFAULT: String = "Dialogue box for upgrades"

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	shop_dialogue.text = "Buy Upgrade"

func _on_mouse_exited():
	shop_dialogue.text = DIALOGUE_DEFAULT
