extends Control

@onready var h_slider: HSlider = $HSlider
@onready var label: Label = $Label

@export var bus_name: String
var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	h_slider.value_changed.connect(_on_value_change)
	label.text = bus_name
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	
func _on_value_change(value:float):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
