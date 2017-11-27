extends Node

const INVERT = Vector2(-1.0, 1.0)
const NORMAL = Vector2(1.0, 1.0)
const GRAVITY = 200.0
const WALK_SPEED = 200

const IDLE_ANIMATION = 'idle'
const MOVING_ANIMATION = 'moving'
const LEFT_WALL_NORMAL = Vector2(1, 0)
const RIGHT_WALL_NORMAL = Vector2(-1, 0)

onready var background_node = get_node('background')
onready var player_node = get_node('player')
onready var player_animation_node = player_node.get_node('sprites')

var velocity = Vector2(0, 0)
var animation = IDLE_ANIMATION
var offset_location = 0

func _ready():
	# Lorsqu'on joue avec le collisions, il faut utiliser
	# le 'set_fixed_process'. Simplement parce que le 'set_fixed_process'
	# est appelé aussitôt que les collisions sont calculées par la MainLoop.
	# Et la fréquence du 'set_fixed_process' dépend du nombre d'images par secondes
	# que vous avez défini dans le projet. Ici c'est 60, donc la MainLoop appelera
	# la fonction _fixed_process 60 fois par secondes
	set_fixed_process(true)

# Ce source vient de la documentation de Godot Engine:
# http://docs.godotengine.org/en/stable/learning/features/physics/kinematic_character_2d.html
func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	animation = MOVING_ANIMATION

	if Input.is_action_pressed('ui_left'):
		velocity.x = -WALK_SPEED

		# Si on se déplace vers la gauche,
		# on inverse verticalement le personnage.
		# Pour faire ça en utilisera le 'set_scale'
		player_node.set_scale(INVERT)
	elif Input.is_action_pressed('ui_right'):
		velocity.x = WALK_SPEED

		# Il ne faut pas oublier de remettre le 'set_Scale' a sa valeur
		# d'origine quand on se déplace a nouveau vers le droite.
		player_node.set_scale(NORMAL)
	else:
		# Si le personnage ne se déplace pas, on re-initialise l'animation
		# A 'idle'
		animation = IDLE_ANIMATION
		velocity.x = 0

	var motion = velocity * delta

	motion = player_node.move(motion)
	player_animation_node.play(animation)

	if player_node.is_colliding():
		var collision_normal = player_node.get_collision_normal()

		motion = collision_normal.slide(motion)
		velocity = collision_normal.slide(velocity)
		player_node.move(motion)

		# A partir de la on gère le fond en parallax.
		# Si le joueur entre en collision avec le mur de droite, alors
		# la normale devra inverser sa vitesse, et donc devra être égale a (-1, 0)
		# Dans le cas ou on entre en collision avec le mur de gauche, la normale
		# devra annuler la vitesse, qui est négative (= -200) et aura pour valeur (1, 0)
		var ratio = 0

		if LEFT_WALL_NORMAL == collision_normal:
			ratio = -WALK_SPEED
		elif RIGHT_WALL_NORMAL == collision_normal:
			ratio = WALK_SPEED

		if ratio != 0:
			# On se base sur la vitesse de déplcaement (ici WALK_SPEED) pour déterminer
			# le déplacement de chaque layer du fond en parallaxe
			offset_location = offset_location - ratio * delta

			background_node.set_scroll_offset(Vector2(offset_location, 0))
