extends Label

@export var vies_max := 5
var vies: int

func _ready():
	vies = vies_max
	mettre_a_jour()

func mettre_a_jour():
	text = "Vies : " + str(vies)

# Appelée quand la balle tombe
func perdre_une_vie(balle):
	vies -= 1
	mettre_a_jour()
	
	if vies > 0:  # ← Changé de <= 0 à > 0
		balle.repositionner()
	else:
		game_over()

func game_over():
	text = "GAME OVER"
	# Attendre un peu avant de mettre en pause ou de recommencer
	await get_tree().create_timer(2.0).timeout
	get_tree().paused = true
	# OU pour recommencer automatiquement :
	# get_tree().reload_current_scene()
