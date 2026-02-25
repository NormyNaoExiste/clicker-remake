extends TextureButton

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)
@export var time:float = 0.1
const INICIAL_SCALE: Vector2 = Vector2.ONE

func _ready() -> void:
	mouse_entered.connect(_button_hovered)
	mouse_exited.connect(_mouse_exited)
	pressed.connect(_button_pressed)
	call_deferred("_init_pivot")

func _init_pivot():
	pivot_offset = self.size/2.0

func _button_pressed():
	var tween = create_tween()
	tween.tween_property(self, "scale", pressed_scale, time).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "scale", hover_scale, time).set_trans(Tween.TRANS_SINE)

func _button_hovered():
	get_tree().create_tween().tween_property(self, "scale", hover_scale, time
	).set_trans(Tween.TRANS_SINE)

func _mouse_exited():
	get_tree().create_tween().tween_property(self, "scale", INICIAL_SCALE, time)
