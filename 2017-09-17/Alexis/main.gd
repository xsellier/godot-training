extends SceneTree

# En faisant une combinaison de 2 noms, essayez de trouver le plus de palindromes possible.
# Par exemple:
# 'fili' et 'ilif' combinés font 'filiilif' qui est un palindrome

# Ajout de deux mots en bout de tableau
const WORDS        = ['mon', 'nom', 'possible', 'romuald', 'laumor', 'pierre', 'erreip', 'ici', 'ici']
var concat_words   = []
var nb_of_palindrome = []

func _init():
	# Concatenation des noms
	# Variable index1 & index2 utilisées par rapport aux deux derniers mots du tableau
    var index1 = 0
    for word1 in WORDS:
        var index2 = 0
        for word2 in WORDS:
            if index1 != index2:
                concat_words.append(word1.to_lower() + word2.to_lower())
            index2 += 1
        index1 += 1

    # Inversement de chacun des noms & test si c'est un palindrome
    for word in concat_words:
        var word_reverse = ""
        for i in range(1, word.length()+1):
            word_reverse += word[-i]

        if word == word_reverse:
            nb_of_palindrome.append(word)

    # Affichage console
    print("Origin words: %s" % [WORDS])
    print("Nb of Palindrome: %s => %s" % [nb_of_palindrome.size(), nb_of_palindrome])

    quit()
