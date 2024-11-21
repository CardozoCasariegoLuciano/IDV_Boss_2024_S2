extends CanvasLayer
@onready var cancha: Node = $"../cancha"

@onready var help_modal: Node2D = $Node

@onready var end_turn_button: Button = $EndTurn_Button
#Turn data
@onready var energy: Label = $Turn_data/Energy/energy
@onready var discard_deck: Label = $"Turn_data/discard_deck/discard deck"
@onready var deck: Label = $Turn_data/deck/deck
#Player turn
@onready var players_turn: Label = $Turns/Label2
#Goals
@onready var player_1_goals: Label = $Goals/player_1_goals
@onready var player_2_goals: Label = $Goals/player_2_goals

var is_config_open = false

func _ready() -> void:
	Global.can_execute.connect(disable_button)
	Global.clean_cards_effect.connect(enable_button)
	Global.on_reduce_energy.connect(change_energy_label)
	Global.try_to_use_card.connect(change_color_label)
	Deck.on_change_quantity.connect(update_cards_hud)
	cancha.on_goal.connect(update_goals)

	energy.text = str(Global.current_player_energy)
	discard_deck.text = str(Deck.get_current_player_DiscardDeck().size())
	deck.text = str(Deck.get_current_player_Deck().size())


func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("Open_config") and !is_config_open):
		var config_view = preload("res://Views/menu_config/menu_config.tscn").instantiate()
		config_view._on_close.connect(_on_close_config)
		add_child(config_view)
		is_config_open = true

func _on_close_config():
	is_config_open = false

func disable_button(can_execute: bool):
	players_turn.text = str(Global.current_player_turn)
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
	
func update_goals():
	player_1_goals.text = str(Global.player_1_goals)
	player_2_goals.text = str(Global.player_2_goals)

func _on_button_button_up() -> void:
	help_modal.visible = true
