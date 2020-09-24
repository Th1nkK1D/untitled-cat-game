extends KinematicBody


enum Directions {NORTH, WEST, SOUTH, EAST}
export(Directions) var player_direction
export var player_position = Vector2()
const CELLSIZE = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _input(event):
	if event.is_action_pressed("ui_up"):
		move_forward()
	elif event.is_action_pressed("ui_right"):
		turn_right()
	elif event.is_action_pressed("ui_left"):
		turn_left()
	update_visual()
	print(player_direction, player_position)
	
func update_visual():
	rotation.y = player_direction * PI / 2
	translation.x = -player_position.x * CELLSIZE
	translation.z = player_position.y * CELLSIZE
	
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
	
func turn_left():
	player_direction = (player_direction + 1) % 4
	
func turn_right():
	player_direction = posmod(player_direction - 1, 4)
