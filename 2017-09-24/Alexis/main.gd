extends SceneTree

# Calcul du mot de contenant le plus de lettre différente
# Avec le texte donné, retourner le mot qui contient le plus de lettre différente.

const TEXT        = 'N’est-il pas diablement aisé de se prendre pour un grand homme quand on ne soupçonne pas le moins du monde qu’un Rembrandt, un Beethoven, un Dante ou un Napoléon ont jamais existé ?'
const LETTERS     = 'abcdefghijklmnopqrstuvwxyzçéèëêàäâïîöôùûü'
var filter_string = ""
var final_word    = ""
var word_size     = 0

func _init():
	for letter in TEXT.to_lower():
		if letter in LETTERS:
			filter_string += letter
		else:
			filter_string += " "

	var array_words = filter_string.split(" ")

	for word in array_words:
		var filter_letter = ""
		var count_letter = 0
		for letter in word:
			if letter in filter_letter:
				filter_letter.replace(letter, "")
			else:
				filter_letter += letter
				count_letter  += 1

				if count_letter > word_size:
					word_size  = count_letter
					final_word = word

	print("Le mot %s, est le plus long avec %s caractères!" % [final_word, word_size])

	quit()