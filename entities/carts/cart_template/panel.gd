extends Panel
@onready var card: Card_template = $".."
@onready var card_sprite: Sprite2D = $"../Sprite2D"
@onready var card_fullscreen: CanvasLayer = $"../CanvasLayer"

var is_hover = false
var can_hover = true

var is_disable = false

func _get_drag_data(_at_position: Vector2) -> Variant:
	if !card_sprite.visible: return
	Global.try_to_use_card.emit(Global.current_player_energy >= card.energy_cost)

	var preview_cart = card_sprite.duplicate()
	preview_cart.scale = card_sprite.scale * 0.4
	preview_cart.modulate.a = 0.7
	preview_cart.z_index=1

	var preview = Control.new()
	preview.add_child(preview_cart)
	
	set_drag_preview(preview)
	card.change_card_visibility(false)
	return card

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

#Emitir una señal al padre para que realice una accion
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data.change_card_visibility(true)

func _on_mouse_entered() -> void:
	if(!is_hover and can_hover):
		hover(1)

func _on_mouse_exited() -> void:
	if(is_hover and can_hover):
		hover(-1)

func _on_gui_input(event: InputEvent) -> void:
	if(!card_sprite.visible):return
	if(event is InputEventMouseButton and event.button_index == 1 and !event.pressed):
		card_fullscreen.visible = true
		if(can_hover): hover(-1)

# 1 para aplicar el hover
#-1 para no aplicarlo
func hover(direction: int):
	card.position.y = card.position.y - 100 * direction
	card.z_index = 0 if (direction!=1) else 1
	is_hover = !is_hover
