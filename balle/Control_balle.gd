extends RigidBody2D

var vitesse_max: float = 300.0
var position_depart: Vector2

func _ready() -> void:
	# Configuration physique IMPORTANTE
	contact_monitor = true
	max_contacts_reported = 4
	continuous_cd = CCD_MODE_CAST_SHAPE  # ← CORRIGÉ ICI
	lock_rotation = true  # Empêche la balle de tourner
	
	# Créer un matériau physique pour la balle
	var physic_material = PhysicsMaterial.new()
	physic_material.bounce = 1.0  # Rebond parfait
	physic_material.friction = 0.0  # Aucune friction
	physics_material_override = physic_material
	
	position_depart = global_position
	lancer_balle()
	body_entered.connect(_on_body_entered)

func lancer_balle():
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	sleeping = false
	
	var direction_x = randf_range(-0.5, 0.5)
	var direction_y = -1  # toujours vers le haut
	
	var direction_depart = Vector2(direction_x, direction_y).normalized()
	
	apply_central_impulse(direction_depart * vitesse_max)

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.linear_velocity.length() > 0:
		var velocity = state.linear_velocity.normalized() * vitesse_max
		
		# EMPÊCHER LES ANGLES TROP PLATS (quand la balle longe les murs)
		# Si l'angle est trop horizontal ou vertical, on le corrige
		if abs(velocity.x) < 50:  # Trop vertical
			velocity.x = 50 if velocity.x > 0 else -50
		if abs(velocity.y) < 50:  # Trop horizontal
			velocity.y = 50 if velocity.y > 0 else -50
		
		state.linear_velocity = velocity.normalized() * vitesse_max

func repositionner():
	global_position = position_depart
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0
	lancer_balle()

func _on_body_entered(body):
	if body.has_method("detruire_brique"):
		body.detruire_brique()
