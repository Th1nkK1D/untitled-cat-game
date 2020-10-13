extends KinematicBody

enum Directions {NORTH, WEST, SOUTH, EAST}
const CELLSIZE = 2

signal arrived(player_position)

export(Directions) var player_direction
export var player_position = Vector2()
export var move_speed = 5
export var turn_speed = 5

var is_transforming = false

onready var target_position = translation
onready var target_rotation = rotation

func _input(event):
	if is_transforming:
		return;
		
	if event.is_action_pressed("ui_up"):
		move_forward()
		is_transforming = true
		$Cat/AnimationPlayer.play("Run")
	elif event.is_action_pressed("ui_right"):
		turn_right()
		is_transforming = true
	elif event.is_action_pressed("ui_left"):
		turn_left()
		is_transforming = true
	
	print(player_direction, player_position)
	
func _process(delta):
	if !translation.is_equal_approx(target_position):
		translation = translation.move_toward(target_position, move_speed * delta)
		
		if translation.is_equal_approx(target_position):
			translation = target_position
			is_transforming = false
			$Cat/AnimationPlayer.play("Idle")
			emit_signal("arrived", player_position)
		
	if !rotation.is_equal_approx(target_rotation):
		rotation = rotation.move_toward(target_rotation, turn_speed * delta)
		
		if rotation.is_equal_approx(target_rotation):
			target_rotation.y = player_direction * PI / 2
			rotation.y = target_rotation.y
			is_transforming = false
		
func move_forward():
	var offset = Vector2()
	
	if player_direction == Directions.NORTH:
		offset.y = 1
	elif player_direction == Directions.WEST:
		offset.x = -1
	elif player_direction == Directions.SOUTH:
		offset.y = -1
	elif player_direction == Directions.EAST:
		offset.x = 1
		
	player_position += offset
	target_position = Vector3(-player_position.x, 0, player_position.y) * CELLSIZE
	
func turn_left():
	player_direction = (player_direction + 1) % 4
	target_rotation.y = rotation.y + PI / 2
	
func turn_right():
	player_direction = posmod(player_direction - 1, 4)
	target_rotation.y = rotation.y - PI / 2

func clone():
	var new_cat = duplicate()
	new_cat.player_position = player_position
	new_cat.player_direction = player_direction
	return new_cat
