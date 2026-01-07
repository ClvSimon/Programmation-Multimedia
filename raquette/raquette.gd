extends CharacterBody2D

var vitesse: float = 400.0

func _ready():
	# Créer un matériau physique pour la raquette
	var physic_material = PhysicsMaterial.new()
	physic_material.bounce = 1.0
	physic_material.friction = 0.0
	
