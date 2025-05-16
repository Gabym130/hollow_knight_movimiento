extends CharacterBody2D

@export var move_speed = 120.0
@export var deceleration = 0.1
var movement = Vector2()

func _physics_process(delta):
	horizontal_movement()
	
	move_and_slide()

func horizontal_movement():
	movement = Input.get_axis("ui_left", "ui_right")
	
	if movement:
		velocity.x = movement * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed * deceleration)
