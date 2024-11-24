extends Control

var texture_paths: Array = PlayerSkins.texture_paths
								
var current_index_p2: int = 0

@export var textures: Array = []

# Referencias a los nodos
@onready var texture_rect: TextureRect = $TextureRect
@onready var left_button: Button = $TextureRect/LeftButton
@onready var right_button: Button = $TextureRect/RightButton
@onready var confirm_button: Button = $Confirm/ConfirmButton

var p2_selection: Texture

func _ready():
	for path in texture_paths:
		textures.append(load(path))

	if textures.size() > 0:
		texture_rect.texture = textures[current_index_p2]
	left_button.pressed.connect(_on_left_button_pressed_p2)
	right_button.pressed.connect(_on_right_button_pressed_p2)
	p2_selection = textures[0]


func _on_right_button_pressed_p2() -> void:
	if textures.size() > 0:
		current_index_p2 = (current_index_p2 + 1) % textures.size()
		texture_rect.texture = textures[current_index_p2]
		p2_selection = textures[current_index_p2]

func _on_left_button_pressed_p2() -> void:
	if textures.size() > 0:
		current_index_p2 = (current_index_p2 - 1 + textures.size()) % textures.size()
		texture_rect.texture = textures[current_index_p2]
		p2_selection = textures[current_index_p2]


func _on_confirm_button_pressed() -> void:
	if (p2_selection == PlayerSkins.skin_player_1):
		_show_error_message("Jugador 2 no puede seleccionar el mismo equipo que el Jugador 1.")
		return 
	
	PlayerSkins.skin_player_2 = p2_selection
	
	if $Confirm/ConfirmButton.text == "Editar":
		$Confirm/ConfirmButton.text = "Confirmar"
		left_button.disabled = false
		right_button.disabled = false
	else:
		_show_error_message("")
		$Confirm/ConfirmButton.text = "Editar"
		left_button.disabled = true
		right_button.disabled = true

# Función para mostrar un mensaje de error
func _show_error_message(message: String) -> void:
	var error_label = $ErrorLabel  # Asegúrate de tener un nodo Label llamado 'ErrorLabel' en tu escena
	error_label.text = message
	error_label.visible = true
