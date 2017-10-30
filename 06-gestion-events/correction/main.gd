extends Control

# Il faut savoir capturer les event mais aussi les marquer comme traité.
# Il existe plusieurs manières de capturer un event dans godot, et il existe deux manières de les marquer comme capturer
# Par défaut vous pouvez utiliser `get_tree().set_input_as_handled()`.
# Il y a une exception pour c'est lorsque vous faites
# self.connect('input_event', self, 'input_event')
# Pour marquer ce genre d'event comme traité, il faut appeler `accept_event()`
# (source: http://docs.godotengine.org/en/stable/learning/features/inputs/inputevent.html)

const DEFAULT_SENTENCE = 'Appuyez sur une touche'
const INVALID_KEY = 'Bonjour, je ne reconnaîs pas la touche qui a été pressée'
const MOUSE_EVENT = 'Arrêtez ça chatouille !'
const KEY_COMBINATIONS = {
  ui_k = 'Bonjour, vous avez appuyé sur K',
  ui_o = 'Bonjour, avez-vous appuyé sur la touche O ?',
  ui_ctrl_k = 'Bonjour, comment allez vous ?',
  ui_ctrl_o = 'Content de voir que vous allez bien !'
}

const DEFAULT_DELAY = 5

var current_delay = 0

onready var label_node = get_node('text')

func _ready():
  label_node.set_text(DEFAULT_SENTENCE)

  # Utilisé pour reset le label au bout de quelques secondes
  set_process(true)

  # Capture les touches du clavier
  set_process_unhandled_key_input(true)

  # Capture toutes les actions, mais nous ne l'utilisons que pour la souris.
  self.connect('input_event', self, 'input_event')

func _process(delta):
  current_delay += delta

  if current_delay > DEFAULT_DELAY:
    update_label(DEFAULT_SENTENCE)

func _unhandled_key_input(key_event):
  # On ne capture que si on appuie sur la touche, pas lorsqu'on relache la touche
  if key_event.pressed:
    var processed = false
    var index = 0
    var keys = KEY_COMBINATIONS.keys()
    var size = keys.size()
    var label = INVALID_KEY

    while not processed and index < size:
      var action = keys[index]

      if key_event.is_action_pressed(action):
        label = KEY_COMBINATIONS[action]

        processed = true

      index += 1

    update_label(label)

    # Marque l'évènement comme traité et empêche sa propagation
    get_tree().set_input_as_handled()

func input_event(event):
  if event.type == InputEvent.MOUSE_BUTTON:
    update_label(MOUSE_EVENT)

    # Marque l'évènement comme traité et empêche sa propagation
    accept_event()

func update_label(text):
  label_node.set_text(text)
  current_delay = 0
