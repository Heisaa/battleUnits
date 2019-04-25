extends KinematicBody2D

export var selected = false setget setSelected
onready var box = $box
onready var label = $label
onready var bar = $bar


signal wasSelected
signal wasDeselected

func setSelected(value):
	if selected != value:
		selected = value
		box.visible = value
		label.visible = value
		bar.visible = value
		if selected:
			emit_signal("wasSelected", self)
		else:
			emit_signal("wasDeselected", self)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("wasSelected", get_parent(),"selectUnit")
	connect("wasDeselected",get_parent(),"deselectUnit")
	box.visible = false
	label.visible = false
	bar.visible = false
	label.text = name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_unit_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				setSelected(not selected)
