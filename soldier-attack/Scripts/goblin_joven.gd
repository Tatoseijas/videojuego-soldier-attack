extends CharacterBody2D

var corazones =8
var atacando = false

@onready var animacionpj = $AnimatedSprite2D
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
	var tiempo_espera = randf_range(1.5, 3.25)
	timer_ataque.start(tiempo_espera)
func iniciar_ataque():
	atacando=true
	animacionpj.play("Ataque")
func recibir_danio(cantidad):
	corazones -= cantidad
	if corazones <=0:
		morir()
func morir():
	queue_free()
func _on_timer_ataque_timeout() -> void:
	if not atacando:
		iniciar_ataque()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animacionpj.animation == "Ataque":
		atacando=false
		colision_espada.set_deferred("disabled", true)
		animacionpj.play("default")
		preparar_proximo_ataque()


func _on_animated_sprite_2d_frame_changed() -> void:
	if animacionpj==null:
		return
	if animacionpj.animation=="Ataque":
		if animacionpj.frame==4:
			colision_espada.set_deferred("disabled", false)


func _on_hitbox_espada_troll_body_entered(body: Node2D) -> void:
	if body.has_method("recibir_danio_jugador"):
		body.recibir_danio_jugador(1)
