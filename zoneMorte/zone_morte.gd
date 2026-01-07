extends Area2D

@onready var nb_vie = $"../NbVie/Vies"

func _on_body_entered(body):
	if body.name == "Balle":
		nb_vie.perdre_une_vie(body)
