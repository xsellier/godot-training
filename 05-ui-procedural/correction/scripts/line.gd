extends Control

# Pour plus d'information voir l'exercice sur la grille procédurale (exercice 03)
export(float) var line_width = 2.0
export(int) var line_length = 250
export(Color) var line_color = Color(1.0, 1.0, 1.0)
export(Vector2) var pos = Vector2(0, 0)

func _draw():
  # Prépare le point d'origine et le point de destination de la première ligne horizontale
  var horizontal_line_origin = Vector2(line_length / -2.0, 0) + pos
  var horizontal_line_target = Vector2(line_length / 2.0, 0) + pos

  draw_line(horizontal_line_origin, horizontal_line_target, line_color, line_width)
