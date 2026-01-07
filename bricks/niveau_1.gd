extends Node2D

var briques_restantes: int = 30
var ui_victoire: Control

func _ready():
	connecter_briques()

func connecter_briques():
	for enfant in get_children():
		if enfant.has_signal("brick_destroyed"):
			enfant.brick_destroyed.connect(_on_brick_destroyed)

	print("Total de briques au départ : ", briques_restantes)

func _on_brick_destroyed():
	briques_restantes -= 1
	print("Brique détruite ! Restantes : ", briques_restantes)

	if briques_restantes <= 0:
		victoire()

func victoire():
	print("🎉 VICTOIRE !")

	# Mettre le jeu en pause
	get_tree().paused = true

	# UI de victoire
	ui_victoire = Control.new()
	ui_victoire.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(ui_victoire)

	# Label
	var label = Label.new()
	label.text = "VICTOIRE !"
	label.add_theme_font_size_override("font_size", 64)
	label.modulate = Color.YELLOW
	label.position = Vector2(350, 250)
	ui_victoire.add_child(label)

	# Bouton Rejouer
	var bouton = Button.new()
	bouton.text = "Rejouer"
	bouton.position = Vector2(400, 350)
	bouton.size = Vector2(200, 60)
	bouton.pressed.connect(_on_rejouer_pressed)
	ui_victoire.add_child(bouton)

func _on_rejouer_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
