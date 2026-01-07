extends Node

@export var vitesse: float = 300.0
@export var fallback_half_width: float = 20.0

var paddle: Node2D

func _ready() -> void:
	paddle = get_parent() as Node2D

func _physics_process(delta: float) -> void:
	var direction: float = 0.0

	if Input.is_action_pressed("p1_left"):
		direction -= 1.0
	if Input.is_action_pressed("p1_right"):
		direction += 1.0

	# Déplacement horizontal
	paddle.position.x += direction * vitesse * delta

	# Taille de la fenêtre (axe X) — type explicite pour éviter l'erreur
	var window_width: float = get_viewport().get_visible_rect().size.x

	# Demi-largeur de la raquette (valeur de secours)
	var half_width: float = fallback_half_width

	# Si la raquette a un Sprite2D nommé "Sprite"
	if paddle.has_node("Sprite"):
		var s := paddle.get_node("Sprite") as Sprite2D
		if s.texture:
			half_width = (s.texture.get_width() * paddle.scale.x) * 0.5
	# Sinon, si elle a une CollisionShape2D avec RectangleShape2D
	elif paddle.has_node("CollisionShape2D"):
		var cs := paddle.get_node("CollisionShape2D") as CollisionShape2D
		if cs.shape is RectangleShape2D:
			half_width = cs.shape.extents.x * paddle.scale.x

	# Empêcher de sortir de l'écran
	paddle.position.x = clamp(paddle.position.x, half_width, window_width - half_width)
