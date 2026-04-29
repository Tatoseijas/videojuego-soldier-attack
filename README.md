# Proyecto: Caballero vs Goblins

Este es mi proyecto. Es un juego de plataformas 2D hecho en **Godot 4**, donde manejás a un caballero que tiene que limpiar un nivel lleno de goblins y trolls para poder pasar por un portal y pelear contra el Boss Final.

## 🕹️ Cómo se juega
* **Moverse:** Teclas "A" y "D".
* **Saltar:** Espacio.
* **Correr:** Mantener el `Shift`.
* **Atacar:** Clic izquierdo.

## 🛠️ Lo que hice en el código
* **Sistema de Daño:** Usé `Area2D` y `CollisionShape2D` para las espadas. Lo más difícil fue sincronizar que el daño solo se active cuando la animación del golpe está en el frame justo.
* **Interfaz (UI):** Armé un sistema de corazones con un `HBoxContainer` que se va actualizando en tiempo real cuando el jugador recibe daño.
* **Cambio de Escenas:** Programé portales y botones de menú que usan `change_scene_to_file` para moverte entre el inicio, el nivel 1 y el jefe final.
* **Enemigos:** Tienen un sistema de ataque automático con un `Timer` aleatorio para que no sea siempre igual.

## 📚 Fuentes y Referencias
Para este proyecto me apoyé en la documentación oficial y en los tutoriales de la comunidad que explican cómo usar el motor desde cero:

1.  **Documentación Oficial de Godot (Manual):**
    * [Mover un personaje con CharacterBody2D](https://docs.godotengine.org/en/stable/tutorials/physics/using_character_body_2d.html)
    * [Uso de Señales (Signals)](https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html)
2.  **Tutoriales de Lógica:**
    * [GDQuest (Youtube/Web)](https://www.gdquest.com/tutorial/godot/learning-paths/godot-4-beginner/)
    * [Heartbeast - Action RPG Series](https://www.youtube.com/watch?v=M8-989Jp564)
3.  **Foros de ayuda:**
    * [Godot Forum](https://forum.godotengine.org/)
4.  **Arte y Assets:**
    * [CraftPix.net - Free 2D Game Assets](https://craftpix.net/freebies/)

## 🏁 Conclusión y Feedback del Proyecto
El resultado final del juego es muy satisfactorio en cuanto a estética y fluidez, logrando un ambiente visual muy cuidado. Sin embargo, como parte del proceso de aprendizaje, identifico los siguientes puntos a mejorar:

**Dificultad y Extensión:** El juego quedó corto y con una curva de dificultad muy baja, resultando bastante fácil de completar para un jugador promedio.

**Variedad de Enemigos:** Mi intención original era incluir un bestiario más amplio con diferentes tipos de ataques y movimientos. Debido a la complejidad técnica que implicaba programar comportamientos de IA más avanzados, preferí priorizar la estabilidad de las mecánicas base (movimiento, ataque y colisiones) para asegurar que el juego funcionara correctamente de principio a fin.
