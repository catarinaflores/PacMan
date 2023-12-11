extends CharacterBody2D

enum Direction {LEFT, RIGHT, UP, DOWN}

@export var speed := 100

var facing_direction := Direction.LEFT
var previous_direction := Vector2.LEFT
var start_position: Vector2

@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var death_sound = %DeathSound
@onready var eat_ghost_sound = %EatGhostSound


func _ready() -> void:
	animated_sprite_2d.play("left")
	start_position = position


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("down"):
		facing_direction = Direction.DOWN
		animated_sprite_2d.play("down")
	elif event.is_action_pressed("up"):
		facing_direction = Direction.UP
		animated_sprite_2d.play("up")
	elif event.is_action_pressed("left"):
		facing_direction = Direction.LEFT
		animated_sprite_2d.play("left")
	elif event.is_action_pressed("right"):
		facing_direction = Direction.RIGHT
		animated_sprite_2d.play("right")


func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	
	match facing_direction:
		Direction.DOWN:
			direction = Vector2.DOWN
		Direction.UP:
			direction = Vector2.UP
		Direction.LEFT:
			direction = Vector2.LEFT
		Direction.RIGHT:
			direction = Vector2.RIGHT
	
	velocity = direction * speed
	var collision := move_and_collide(velocity * delta)
	
	if collision:
		if not collision.get_collider() is CharacterBody2D:
			move_and_collide(previous_direction * speed * delta)
	else:
		previous_direction = direction


func _die() -> void:
	GameManager.lives -= 1
	death_sound.play()
	animated_sprite_2d.pause()
	var tween := get_tree().create_tween()
	tween.tween_property(self, "modulate", Color.TRANSPARENT, 2)
	tween.tween_callback(_restart)
	call_deferred("set_process_mode", Node.PROCESS_MODE_DISABLED)
	# process_mode = Node.PROCESS_MODE_DISABLED


func _restart() -> void:
	modulate = Color.WHITE
	process_mode = Node.PROCESS_MODE_INHERIT
	position = start_position
	facing_direction = Direction.LEFT
	animated_sprite_2d.play("left")



func _on_ghost_detector_body_entered(body):
	# Collided with ghost
	if GameManager.is_running_mode:
		body.kill()
		GameManager.eat_ghost()
		eat_ghost_sound.play()
	else:
		_die()
