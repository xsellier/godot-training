# Exercice 2017-09-24
extends SceneTree

const TEXT = 'N’est-il pas diablement aisé de se prendre pour un grand homme quand on ne soupçonne pas le moins du monde qu’un Rembrandt, un Beethoven, un Dante ou un Napoléon ont jamais existé ?'

# L'utilisation d'une expression régulière est fortement conseillée dans ce cas
# On peut effectivement à l'aide d'une expression régulière trouver les caractères dupliqué dans une phrase.
# Détaillons la regexp suivante:
# - (\\w) : Sélectionne tous les caractères de l'alphabet (y compris les é, è, ç, ô ...)
#         - Les parenthèses permettent de sélectionner ce caractère et de pouvoir y accéder en utilisant "\\1".
# - (?=.*?\\1) : Sélectionne s'il y a lieu le caractère suivant de la regexp précèdente, et si ce caractère est présent une nouvelle fois dans cette chaîne il le sélectionne.
#         - Les parenthèses permettent de sélectionner ce caractère et de pouvoir y accéder en utilisant "\\2".
#         - Le ?= sélectionne les caractères suivant la condition après le ".*?\\1"
#         - Le .* sélectionne tous les caractères
#         - Le ?\\1 sélectionne tous les caractères qui ont été capturés par le premier "(\\w)"
#         - Le .*?\\1 combin sélectionne tous les caractères qui ont été capturés par "(\\w)"
const DOUBLON_REGEXP = '(\\w)(?=.*?\\1)'

# Sélectionne les mots (sans ponctuation)
const WORD_REGEXP = '(\\w+)'

func extract_words(text):
  var words = []
  var index = 0
  var select_word = RegEx.new()

  select_word.compile(WORD_REGEXP)

  # Cherche la première occurence de l'expression régulière
  while select_word.find(text.to_lower(), index) >= 0:
    # S'il y a eu un match alors on récupère le résultat de la capture
    var word = select_word.get_capture(0)

    words.append(word)

    # Puis on calcule l'index suivant, pour ce faire on prend l'index
    # du premier match et ensuite on y ajoute la taille du match que nous avons eu
    index = select_word.get_capture_start(0) + word.length()

  return words

func get_word_length_deduplicated(word):
  var length = word.length()
  var letter_doublon = RegEx.new()
  var index = 0

  letter_doublon.compile(DOUBLON_REGEXP)

  # Cherche la première occurence de l'expression régulière
  while letter_doublon.find(word.to_lower(), index) >= 0:
    # S'il y a eu un match alors on récupère le résultat de la capture
    var duplicated_char = letter_doublon.get_capture(0)

    # On soustrait le nombre de caractère dupliqué à la longueur du mot
    length -= duplicated_char.length()

    # Puis on calcule l'index suivant, pour ce faire on prend l'index
    # du premier match et ensuite on y ajoute la taille du match que nous avons eu
    index = letter_doublon.get_capture_start(0) + duplicated_char.length()

  return length

func _init():
  var words = extract_words(TEXT)
  var max_words = []
  var max_length = 0

  for word in words:
    var deduplicated_length = get_word_length_deduplicated(word)

    if deduplicated_length > max_length:
      # Si la longueur du mot a été battue on initialise un nouveau tableau
      max_length = deduplicated_length
      max_words = [word]
    elif deduplicated_length == max_length:
      # Sinon on ajoute le mot trouvé à la liste des mots trouvés
      max_words.append(word)
  
  print('Il y a %s mot(s) contenant %s caractères différents' % [max_words.size(), max_length])
  print(max_words)

  quit()