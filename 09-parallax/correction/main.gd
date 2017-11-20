extends ParallaxBackground

var offset_location = 0

func _ready():
	set_process(true)

func _process(delta):
	offset_location = offset_location - 250 * delta

	set_scroll_offset(Vector2(offset_location, 0))
