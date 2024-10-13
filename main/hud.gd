extends CanvasLayer

@onready var end_turn_button: Button = $EndTurn_Button
@onready var energy: Label = $Turn_data/Energy/energy
@onready var discard_deck: Label = $"Turn_data/discard_deck/discard deck"
@onready var deck: Label = $Turn_data/deck/deck

func _ready() -> void:
	Global.can_execute.connect(disable_button)
	Global.clean_cards_effect.connect(enable_button)
	Global.on_reduce_energy.connect(change_energy_label)
	Global.try_to_use_card.connect(change_color_label)
	Deck.on_change_quantity.connect(update_cards_hud)

	energy.text = str(Global.current_player_energy)
	discard_deck.text = str(Deck.get_current_player_DiscardDeck().size())
	deck.text = str(Deck.get_current_player_Deck().size())

func disable_button(can_execute: bool):
	if(can_execute):
		end_turn_button.disabled = true
	
func enable_button(can_clean: bool):
	if(can_clean):
		end_turn_button.disabled = false
		
func change_energy_label(energy_left: int):
	energy.text = str(energy_left)

func change_color_label(value: bool):
	if !value:
		var tween = get_tree().create_tween()
		tween.tween_property(energy, "modulate", Color.RED, 0.1).set_trans(Tween.TRANS_SINE)
		tween.tween_property(energy, "scale", Vector2(2,2), 0.1).set_trans(Tween.TRANS_SINE)
		tween.tween_property(energy, "scale", Vector2(1,1), 0.1).set_trans(Tween.TRANS_SINE)
		tween.tween_property(energy, "modulate", Color.WHITE, 1.5).set_trans(Tween.TRANS_SINE)

func update_cards_hud():
	discard_deck.text = str(Deck.get_current_player_DiscardDeck().size())
	deck.text = str(Deck.get_current_player_Deck().size())
