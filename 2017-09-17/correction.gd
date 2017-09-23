# Exercice 2017-09-17
extends SceneTree

# Il est préférable de définir une règle de codage pour la définition de constante.
# Ici nous avons choisi de mettre les contstantes en capitale, ainsi nous les reconnaitrons plus facilement
# lorsque nous essaierons de relire ce bout de code
const WORDS = ['mon', 'nom', 'possible', 'romuald', 'laumor', 'pierre', 'erreip']

# Prend un Array en paramètre et retourne l'ensemble des combinaisons
# de cet Array
func combine_words(words):
  var combinaisons = []

  for premier_word in words:
    for second_word in words:
      # Concatène deux mots
      combinaisons.append(premier_word + second_word)


  return combinaisons

# La convention veut qu'une fonction dont le nom commence par 'is_' retourne un booléen.
# Retourne 'true' si le mot est un palindrome, 'false' sinon
func is_palindrome(word):
  var result = true
  var length = word.length()
  var index = 0

  # Calcule le centre du mot
  var milieu = ceil(length / 2.0)

  # Retourne 'true' si la longueur du mot est pair, 'false' sinon
  var is_odd = not (length % 2)

  while index < length and result:
    var first_letter = word.substr(index, 1)
    var last_letter = word.substr(length - index - 1, 1)

    # Si on est sur un mot avec une longeur pair
    # OU
    # Si la lettre que nous examinons n'est pas celle du milieu du mot de longueur impair
    if is_odd or index != milieu:
      result = first_letter == last_letter

    index += 1

  return result

func _init():
  var words = combine_words(WORDS)
  var palindromes = []

  for word in words:
    if is_palindrome(word):
      palindromes.append(word)

  print('Liste de palindromes:')
  print(palindromes)

  # Liste de palindromes:
  # [monnom, nommon, romualdlaumor, pierreerreip, erreippierre]

  quit()