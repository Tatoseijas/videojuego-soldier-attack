extends Node2D


func _on_zona_muerte_body_entered(body: Node2D) -> void:
	if body.name == "Jugador":
		get_tree().change_scene_to_file("res://Escenas/moriste.tscn")
