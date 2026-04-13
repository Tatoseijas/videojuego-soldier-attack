extends CharacterBody2D

const velocidad_caminando=300
const velocidad_corriendo =500
const JUMP_VELOCITY = -400.0
@onready var animacion=$AnimatedSprite2D

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("atacar"):
		print("atacando!!")
	
	if Input.is_action_pressed("defender"):
		print("defendiendo")
	
	var velocidad_actual=velocidad_caminando
	if Input.is_action_pressed("correr"):
		velocidad_actual=velocidad_corriendo
	
	var direction := Input.get_axis("mover_izq", "mover_der")

	if direction:
		velocity.x=direction * velocidad_actual
		if direction<0:
			animacion.flip_h=true
		elif direction>0:
			animacion.flip_h=false
	else:
		velocity.x=move_toward(velocity.x, 0, velocidad_actual)
	
	if Input.is_action_just_pressed("atacar"):
		animacion.play("Ataque")
	elif Input.is_action_pressed("defender"):
		animacion.play("Defend")
		velocity.x=0
	elif not is_on_floor():
		animacion.play("Salto")
	
	elif direction != 0:
		if Input.is_action_pressed("correr"):
			animacion.play("Correr")
		else:
			animacion.play("Caminar")
	
	else:
		if animacion.animation != "Ataque" or not animacion.is_playing():
			animacion.play("Quieto")
	
	
	move_and_slide()
