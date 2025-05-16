extends CharacterBody2D

@export_category("Movement variable")
@export var move_speed = 120.0
@export var deceleration = 0.1
@export var gravity = 500.0
var movement = Vector2()

@export_category("Jump variable")
@export var jump_speed = 190.0
@export var acceleration = 290.0
@export var jump_amount = 2

func _physics_process(delta):
	velocity.y  += gravity * delta
	
	horizontal_movement()
	jump_logic()
	set_animations()
	flip()
	
	move_and_slide()

func horizontal_movement():
	movement = Input.get_axis("ui_left", "ui_right")
	
	if movement:
		velocity.x = movement * move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, move_speed * deceleration)

func set_animations():
	if velocity.x != 0:
		$anim.play("Move")
	if velocity.x == 0:
		$anim.play("Idle")

func flip():
	if velocity.x > 0.0:
		scale.x = scale.y * 1
	if velocity.x < 0.0:
		scale.x = scale.y * -1


func jump_logic():
	if is_on_floor():
		jump_amount = 2
		if Input.is_action_just_pressed("ui_accept"):
			jump_amount -= 1
			velocity.y -= lerp(jump_speed, acceleration, 0.1)
