extends CharacterBody2D

var corazones =15
var atacando = false

@onready var animacion = $AnimatedSprite2D
@onready var timer_ataque = $TimerAtaque
@onready var colision_espada = $HitboxEspadaTroll/CollisionShape2D

func _ready() -> void:
	colision_espada.disabled = true
	preparar_proximo_ataque()
	
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity+= get_gravity() * delta
	move_and_slide()
func preparar_proximo_ataque():
	var tiempo_espera = randf_range(1.5, 4)
	timer_ataque.start(tiempo_espera)
func iniciar_ataque():
	atacando=true
	animacion.play("Ataque")
func recibir_danio(cantidad):
	corazones -= cantidad
	if corazones <=0:
		morir()
func morir():
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Escenas/ganaste.tscn")
func _on_timer_ataque_timeout() -> void:
	if not atacando:
		iniciar_ataque()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animacion.animation == "Ataque":
		atacando=false
		colision_espada.set_deferred("disabled", true)
		animacion.play("default")
		preparar_proximo_ataque()



func _on_hitbox_espada_troll_body_entered(body: Node2D) -> void:
	if body.has_method("recibir_danio_jugador"):
		body.recibir_danio_jugador(1)


func _on_animated_sprite_2d_frame_changed() -> void:
	if animacion==null:
		return
	if animacion.animation=="Ataque":
		if animacion.frame==4:
			colision_espada.set_deferred("disabled", false)
