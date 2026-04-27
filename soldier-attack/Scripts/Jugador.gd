extends CharacterBody2D

const velocidad_caminando = 300
const velocidad_corriendo = 500
const JUMP_VELOCITY = -400.0
var corazones = 3
var esta_defendiendo = false
var es_invencible = false
var esta_muerto = false
@export var imagen_corazon_lleno: Texture2D
@export var imagen_corazon_vacio: Texture2D

@onready var contenedor_corazones = $UI/HBoxContainer
@onready var animacion = $AnimatedSprite2D
@onready var colision_espada = $HitboxEspada/CollisionShape2D

func _physics_process(delta: float) -> void:
	if esta_muerto:
		if not is_on_floor():
			velocity += get_gravity() * delta
		move_and_slide()
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var velocidad_actual = velocidad_caminando
	if Input.is_action_pressed("correr"):
		velocidad_actual = velocidad_corriendo
	var direction := Input.get_axis("mover_izq", "mover_der")
	esta_defendiendo = Input.is_action_pressed("defender")
	if direction:
		velocity.x = direction * velocidad_actual
		if direction < 0:
			animacion.flip_h = true
		elif direction > 0:
			animacion.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, velocidad_actual)
	var esta_atacando = animacion.animation == "Ataque" and animacion.is_playing()
	if esta_defendiendo:
		animacion.play("Defend")
		velocity.x = 0 # Nos frenamos al defender
	elif Input.is_action_just_pressed("atacar"):
		animacion.play("Ataque")
	elif not is_on_floor() and not esta_atacando:
		animacion.play("Salto")
	elif direction != 0 and not esta_atacando:
		if Input.is_action_pressed("correr"):
			animacion.play("Correr")
		else:
			animacion.play("Caminar")
	else:
		if not esta_atacando:
			animacion.play("Quieto")
	move_and_slide()
func _on_animated_sprite_2d_animation_finished() -> void:
	if animacion.animation == "Ataque":
		colision_espada.set_deferred("disabled", true)
func _on_animated_sprite_2d_frame_changed() -> void:
	if animacion.animation == "Ataque":
		if animacion.frame == 2:
			colision_espada.set_deferred("disabled", false)
func _ready():
	colision_espada.disabled=true
	actualizar_corazones_ui()
func _on_hitbox_espada_body_entered(body: Node2D) -> void:
	if body.has_method("recibir_danio"):
		body.recibir_danio(1)
func recibir_danio_jugador(cantidad):
	if esta_defendiendo:
		return
	if es_invencible:
		return
	corazones_restar(cantidad)
func actualizar_corazones_ui ():
	var lista_corazones = contenedor_corazones.get_children()
	for i in range(lista_corazones.size()):
		if i < corazones:
			lista_corazones[i].texture = imagen_corazon_lleno
		else:
			lista_corazones[i].texture = imagen_corazon_vacio
func corazones_restar(cantidad):
	corazones -= cantidad
	actualizar_corazones_ui()
	if corazones <= 0:
		morir()
func morir():
	esta_muerto=true
	velocity.x =0
	animacion.play("Muerte")
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://moriste.tscn")
