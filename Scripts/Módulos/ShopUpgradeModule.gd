extends Panel

@onready var shop_dialogue: Label = $"../ShopDialogue"


@export var upgrade_text: String

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)
@export var time:float = 0.2
const INITIAL_SCALE = Vector2.ONE

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	call_deferred("_init_pivot")


func _init_pivot():
	pivot_offset = size/2

func _on_mouse_entered():
	get_tree().create_tween().tween_property(self, "scale", hover_scale, time).set_trans(Tween.TRANS_SINE)
	shop_dialogue.text = str(upgrade_text)
	shop_dialogue.show()


func _on_mouse_exited():
	get_tree().create_tween().tween_property(self, "scale", INITIAL_SCALE, time).set_trans(Tween.TRANS_SINE)
	shop_dialogue.hide()
func _pressed():
	var tween = create_tween()
	tween.tween_property(self, "scale", pressed_scale, time).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", hover_scale, time).set_trans(Tween.TRANS_SINE)
