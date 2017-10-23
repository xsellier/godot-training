extends Control

const DECAL = Vector2(-400, 0)

# Un noeud de type tween, permet de faire des animations procédurales.
# C'est mieux d'utiliser un noeud de type Tween qu'un noeud de type AnimationPlayer pour faire des animations procédurales
# car le noeud de type Tween permet d'avoir des valeurs de départs et d'arrivées dynamiques, tandis qu'un AnimationPlayer doit avoir des valeurs fixes.
# Et donc une AnimationPlayer démarrera toujours au même point, tandis qu'un Tween node reprendra la ou il s'est arrêté.
onready var tween_node = get_node('tween')

onready var label_node = get_node('text')
onready var line_node = get_node('line')

func initialize(character):
  label_node.set_text(character)
  start_animation()

func start_animation():
  # On utilise le noeud Label pour se positionner, car le noeud 'line' possède exactement la même taille.
  # Et donc la même origine. Nous aurions aussi pu prendre l'origine du noeud 'line' plutôt que celui du noeud
  # label, mais cela aurait demandé plus de ligne de code.
  var target_pos = label_node.get_pos()

  tween_node.interpolate_property(label_node, 'rect/pos', target_pos + DECAL, target_pos, 1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.0)
  tween_node.interpolate_property(label_node, 'visibility/opacity', 0.0, 1.0, 1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.0)

  tween_node.interpolate_property(line_node, 'rect/pos', target_pos - DECAL, target_pos, 1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.0)
  tween_node.interpolate_property(line_node, 'visibility/opacity', 0.0, 1.0, 1.0, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.0)

  # Pour démarrer l'animation
  tween_node.start()
