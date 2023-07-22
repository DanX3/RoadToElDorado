extends PanelContainer
class_name InventorySlot

@export var texture: Texture2D : set = _set_texture


func _set_texture(other: Texture2D):
	texture = other
	$Control/Sprite2D.texture = texture
