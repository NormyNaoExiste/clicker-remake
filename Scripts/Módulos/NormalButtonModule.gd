extends Button

@export var hover_scale: Vector2 = Vector2(1.1, 1.1)
@export var pressed_scale: Vector2 = Vector2(0.9, 0.9)
@export var time:float = 0.2
@export var transition_s = Tween.TRANS_SINE
@export var transition_e = Tween.TRANS_BOUNCE

@export var type: String = ""

const INICIAL_SCALE: Vector2 = Vector2.ONE


func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)
	
	call_deferred("_init_pivot")

func _init_pivot():
	pivot_offset = size/2

func _on_mouse_entered():
	get_tree().create_tween().tween_property(self, "scale", hover_scale, time).set_trans(transition_s)

func _on_mouse_exited():
	get_tree().create_tween().tween_property(self, "scale", INICIAL_SCALE, time).set_trans(transition_e)

func _on_pressed():
	var tween = create_tween()
	tween.tween_property(self, "scale", pressed_scale, time).set_trans(transition_s)
	tween.tween_property(self, "scale", hover_scale, time) .set_trans(transition_s)
