extends Label

@export var vies_max := 5
var vies: int

func _ready():
	vies = vies_max
	add_theme_font_size_override("font_size", 32) # 👈 taille du texte
	mettre_a_jour()

func mettre_a_jour():
	text = "Vies : " + str(vies)

func perdre_une_vie(balle):
	vies -= 1
	mettre_a_jour()
	
	if vies > 0:
		balle.repositionner()
	else:
		game_over()

func game_over():
	text = "GAME OVER"
	add_theme_font_size_override("font_size", 48) # 👈 plus gros pour le game over
	
	await get_tree().create_timer(2.0).timeout
	get_tree().paused = true
