extends Control

@onready var title: Label = $Label

var player: int

func _on_confirm() -> void:
	visible = false

func init_deck_selection(playerID: int):
	visible = true
	self.player =  playerID
	title.text = "Mazo del jugador: " + str(player)
	
#Mostrar la cantidad total de cartas hasta el momento
#generar con cada carta un selector para elegir la cantidad de cada carta
#modificar el metoco generate_default_deck del CARD_BANK para que tome esta config
