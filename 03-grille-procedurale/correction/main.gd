extends Node2D

const LINE_WIDTH = 2.0

export(Color) var grid_color = Color(1.0, 1.0, 1.0)
export(Vector2) var size = Vector2(250, 250)
export(Vector2) var interval = Vector2(15, 15)
export(float) var rotation = 30

func _ready():
  # On utilise fixed_process car cela permet de ne pas avoir de stutter avec le rendu de l'image.
  # Si nous avions utilisé process (idle), le rendu de la grille aurait été effectué uniquement lorsque
  # la boucle principale de la scène aurait eu du temps 'libre'. Autrement dit, en cas de surcharge, le dessin ne se rafraichira pas
  # et l'utilisateur ne verra pas la grille se mettre à jour.
  set_fixed_process(true)

func _fixed_process(delta):
  # On incrémente l'angle de la grille pour faire tourner la grille.
  rotation += delta
  update()
  
func _draw():
  var size_interval_ratio = size / interval
  var origin = size / 2.0
  var half_size = size_interval_ratio / 2.0

  # Prépare le point d'origine et le point de destination de la première ligne horizontale
  var horizontal_line_origin = Vector2(-origin.x, 0)
  var horizontal_line_target = Vector2(origin.x, 0)

  # Prépare le point d'origine et le point de destination de la première ligne verticale
  var vertical_line_origin = Vector2(0, origin.y)
  var vertical_line_target = Vector2(0, -origin.y)

  # Calcule le nombre de ligne que l'on devra afficher
  var nb_lines = int(floor(size_interval_ratio.x) + 1)

  # Calcule le nombre de colonne que l'on devra afficher
  var nb_columns = int(floor(size_interval_ratio.y) + 1)

  # Les decal permettent de centrer nos lignes/colonnes par rapport a notre origine
  var nb_line_float_decal = size_interval_ratio.x + 1 - nb_lines
  var nb_columns_float_decal = size_interval_ratio.y + 1 - nb_columns

  # Dessine les lignes horizontales  
  for index in range(0, nb_lines):
    var offset = Vector2(nb_columns_float_decal * interval.y / -2.0, (index - half_size.x) * interval.x)
    var origin = horizontal_line_origin + offset
    var target = horizontal_line_target + offset

    draw_line(origin.rotated(rotation), target.rotated(rotation), grid_color, LINE_WIDTH)

  # Dessine les lignes verticales
  for index in range(0, nb_columns):
    var offset = Vector2((index - half_size.y) * interval.y, nb_line_float_decal * interval.x / -2.0)
    var origin = vertical_line_origin + offset
    var target = vertical_line_target + offset

    draw_line(origin.rotated(rotation), target.rotated(rotation), grid_color, LINE_WIDTH)

    