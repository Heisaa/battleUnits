extends Node2D

var selectedUnits = []

onready var button = preload("res://scenes/Button.tscn") 
var buttons = []

func selectUnit(unit):
	if not selectedUnits.has(unit):
		selectedUnits.append(unit)
	print("selected %s" % unit.name)
	createButtons()

func deselectUnit(unit):
	if selectedUnits.has(unit):
		selectedUnits.erase(unit)
	print("deselected %s" % unit.name)
	createButtons()

func createButtons():
	deleteButtons()
	for unit in selectedUnits:
		if not buttons.has(unit.name):
			var but = button.instance()
			but.connectMe(self, unit.name)
			but.set_position(Vector2(buttons.size() * 100 + 20, 15))
			$"UI/Base".add_child(but)
			buttons.append(but.name)

func deleteButtons():
	for but in buttons:
		if $"UI/Base".has_node(but):
			var b = $"UI/Base".get_node(but)
			b.queue_free()
			$"UI/Base".remove_child(b)
	buttons.clear()

func wasPressed(obj):
	for unit in selectedUnits:
		if unit.name == obj.name:
			unit.setSelected(false)
			break

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
