# Exercice 2017-10-23
extends Control

const CHARACTERS_PATH = 'res://data/characters.json'
const CHARACTER_SCENE = preload('res://scenes/character.scn')

var CHARACTERS = {}

onready var list_node = get_node('container/right/scroll/list')
onready var pick_node = get_node('container/left/container/container/tirerAuSort')
onready var reset_node = get_node('container/left/container/container/reset')

onready var selected_characters_node = get_node('container/left/container/scroll/list')
onready var scroll_container_node = get_node('container/left/container/scroll')
onready var tween_node = get_node('tween')

func _ready():
  reset()

  pick_node.connect('pressed', self, 'select_character')
  reset_node.connect('pressed', self, 'reset')

  # Permet de faire l'autoscroll
  selected_characters_node.connect('minimum_size_changed', self, 'autoscroll', [], CONNECT_DEFERRED)

func reset():
  # Reset le panneau de gauche
  load_data()
  update_pick_button()
  update_right_panel()
  clear_node(selected_characters_node)

func clear_node(node):
  for child in node.get_children():
    node.remove_child(child)

    # Appeler le free en call deferred permet e librer la mémoire
    # Un remove_child ne suffit pas. Ne pas appeler le 'free' mène a une mémory leak.
    # Et personne ne veut de memory leak.
    child.call_deferred('free')

func update_right_panel():
  clear_node(list_node)

  for character in CHARACTERS.keys():
    var label = Label.new()

    label.set_text(character)
    label.set_align(Label.ALIGN_CENTER)

    list_node.add_child(label)

func update_pick_button():
  pick_node.set_disabled(not CHARACTERS.keys().size() > 0)

func select_character():
  var odds = compute_odds()
  var choosen_character = pick_random_character(odds)
  var character_scene_instance = CHARACTER_SCENE.instance()

  selected_characters_node.add_child(character_scene_instance)
  character_scene_instance.call_deferred('initialize', choosen_character)

  update_pick_button()
  update_right_panel()

func autoscroll():
  var scroll_container_size = scroll_container_node.get_size()
  var selected_characters_size = selected_characters_node.get_size()
  var vertical_scroll_index = (selected_characters_size - scroll_container_size).y
  var current_scroll = scroll_container_node.get_v_scroll()

  # Animation l escroll, afin qu'il paraisse plus naturel
  tween_node.interpolate_method(scroll_container_node, 'set_v_scroll', current_scroll, vertical_scroll_index, 0.5, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.0)
  tween_node.start()

func load_data():
  var file = File.new()

  file.open(CHARACTERS_PATH, file.READ)

  CHARACTERS.parse_json(file.get_as_text())
  
  file.close()

# Voir exercice 04
# Tire une personne au sort en se basant sur les 'odds'
func pick_random_character(odds):
  randomize()

  var value = randf() * odds
  var characters = CHARACTERS.keys()
  var character = characters[0]
  var current_odds = 0
  var index = 0

  # Plutôt que d'utiliser un tableau, nous tirons au sort une valeur entre [0, odss]
  # Puis nous additions les odds les unes après les autres dans les odds sont inférieures
  # à la valeur tirée au sort nous continuons a parcourir le tableau et donc a ajouter les odds.
  # Dès que la valeur dépasse les odds, on interromp la boucle et on retourne le dernier character
  # dont les odds additionnés étaient inférieurs à la valeur tirée au sort
  while current_odds < value and index < characters.size():
    character = characters[index]
    current_odds += float(CHARACTERS[character])

    index += 1

  # Enlève le character choisit pour ne pas le tirer deux fois.
  CHARACTERS.erase(character)

  return character

# Afin de respecter les lois de probabilité, doit faire la somme des
# valeurs pour chacune des personnes afin de pouvoir les tirer au sort
func compute_odds():
  var odds = 0

  for character in CHARACTERS.keys():
    odds += float(CHARACTERS[character])

  return odds
