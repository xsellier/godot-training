extends Node

const BALL_SCENE = preload('res://ball.tscn')

func _ready():
  spawn()

func spawn(ball=null):
  # On supprime l'ancienne balle pour éviter les fuites mémoires
  if ball != null:
    self.remove_child(ball)
    ball.call_deferred('free')

  # On instancie la nouvelle balle
  var ball_scene = BALL_SCENE.instance()

  # On récupère le noeud permettant de détecter si la balle est visible
  var visibility_notifier_node = ball_scene.get_node('visibilityNotifier')

  # Lorsque la balle sort de l'écran on appelle la fonction 'spawn'
  visibility_notifier_node.connect('exit_screen', self, 'spawn', [ball_scene])

  # On ajoute la balle à la scène courante
  add_child(ball_scene)