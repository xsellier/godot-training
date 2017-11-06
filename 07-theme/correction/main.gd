extends Control

onready var popup_node = get_node('WindowDialog')

func _ready():
  popup_node.show()
