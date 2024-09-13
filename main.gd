extends Node

@onready var cartas: Node = $cartas
@export var cart_scene: PackedScene

const CANT_CARTS = 4


func _on_remove_cart(node: Node) -> void:
	if cartas.get_children().size() - 1 <= 0:
		Global.can_execute = true
		$CartsConfig/CreationDelay.start()
		
func _on_creation_delay() -> void:
	generate_carts()

func generate_carts():
	for i in range(CANT_CARTS):
		create_cart(i)
	Global.can_execute = false
	
func create_cart(index: int):
		var newCart: Cart = cart_scene.instantiate()
		cartas.add_child.call_deferred(newCart)
		newCart.size = Vector2(92, 176)
		newCart.color = "8f3c5a"
		
		var path_follow_2d: PathFollow2D = $CartsConfig/CreationCartPath/PathFollow2D
		path_follow_2d.progress = 100 * index
		newCart.global_position = path_follow_2d.global_position
