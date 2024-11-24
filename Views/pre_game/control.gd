extends Control

var texture_paths: Array = PlayerSkins.texture_paths

var current_index_p1: int = 0
var current_index_p2: int = 0

@export var textures: Array = []

# Referencias a los nodos
@onready var texture_rect: TextureRect = $TextureRect
@onready var left_button: Button = $TextureRect/LeftButton
@onready var right_button: Button = $TextureRect/RightButton

var p1_selection: Texture

func _ready():
	for path in texture_paths:
		textures.append(load(path))

	if textures.size() > 0:
		texture_rect.texture = textures[current_index_p1]
	left_button.pressed.connect(_on_left_button_pressed)
	right_button.pressed.connect(_on_right_button_pressed)
	p1_selection = textures[0]

func _on_left_button_pressed():
	if textures.size() > 0:
		current_index_p1 = (current_index_p1 - 1 + textures.size()) % textures.size()
		texture_rect.texture = textures[current_index_p1]
		p1_selection = textures[current_index_p1]

func _on_right_button_pressed():
	if textures.size() > 0:
		current_index_p1 = (current_index_p1 + 1) % textures.size()
		texture_rect.texture = textures[current_index_p1]
		p1_selection = textures[current_index_p1]


func _on_button_pressed() -> void:
	if (p1_selection == PlayerSkins.skin_player_2):
		_show_error_message("Jugador 1 no puede seleccionar el mismo equipo que el Jugador 2.")
		return 

	PlayerSkins.skin_player_1 = p1_selection
	
	if $Confirm/ConfirmButton.text == "Editar":
		$Confirm/ConfirmButton.text = "Confirmar"
		left_button.disabled = false
		right_button.disabled = false
	else:
		_show_error_message("")
		$Confirm/ConfirmButton.text = "Editar"
		left_button.disabled = true
		right_button.disabled = true

func _show_error_message(message: String) -> void:
	var error_label = $ErrorLabel
	error_label.text = message
	error_label.visible = true
