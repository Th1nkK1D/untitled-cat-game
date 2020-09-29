extends Spatial


const CatScene = preload('res://Actors/Cat.tscn')
onready var cats = $Cats

func _ready():
	cats.add_child(CatScene.instance())

func _input(event):
	if event.is_action_pressed("ui_accept"):
		clone_and_turn_left(0)
		
func clone_and_turn_left(idx):
	var cloned_cat = cats.get_child(idx).clone()
	cloned_cat.turn_left()
	cats.add_child(cloned_cat)
