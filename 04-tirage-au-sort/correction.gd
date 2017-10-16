# Exercice 2017-10-10
extends SceneTree

const CHARACTERS = {
  Jean = 0.015,
  Pierre = 0.0089,
  Sophie = 0.000059,
  Jeanne = 0.010045,
  Philibert = 0.0149,
  JeanLuc = 0.0198,
  AnneSophie = 0.01024,
  Elizabeth = 1.010085,
  Maurice = 0.018901,
  Morticia = 0.0200401
}

# Utilisé pour stocker les informations de l'ordre de passage calculé dynamiquement en fonction de CHARACTERS
var numbers = []

# Génère le tableau 'numbers'.
func compute_numbers():
  var index = 1

  # Pour chacun des 'CHARACTERS' ajoute un index dans le tableau 'numbers' incrémenté
  for item in CHARACTERS.keys():
    numbers.append(index)

    index += 1

# Calculer l'ordre de passage d'un 'character'
func compute_order_for_character(character):
  randomize()

  # En utilisant le tableau 'numbers' on génère un nombre entre 0 et 'numbers.size()'
  # pour avoir un numro d'ordre de passage
  var order_index = randi() % numbers.size()
  var order = numbers[order_index]

  # On supprime ensuite ce numéro car on ne peut pas tirer deux fois le
  # même numéro (sinon ça fait des conflits dans la file)
  numbers.remove(order_index)

  return order

# Afin de respecter les lois de probabilité, doit faire la somme des
# valeurs pour chacune des personnes afin de pouvoir les tirer au sort
func compute_odds():
  var odds = 0

  for character in CHARACTERS.keys():
    odds += float(CHARACTERS[character])

  return odds

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
  
  return character

func _init():
  # Phase d'initialisation
  compute_numbers()
  var odds = compute_odds()

  for character in CHARACTERS.keys():
    var order = compute_order_for_character(character)

    print('%s va passer en position numéro: %s' % [character, order])

  var choosen_character = pick_random_character(odds)

  print('%s a été tiré au sort' % [choosen_character])

  quit()