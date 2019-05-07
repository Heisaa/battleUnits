extends Camera2D

export var panSpeed = 20.0
export var speed = 20.0
export var zoomSpeed = 10.0
export var zoomSmoothing = 0.1

export var zoomMin = 0.25
export var zoomMax = 3.0
export var marginX = 10.0
export var marginY = 10.0

var mousePos = Vector2()
var mousePosGlobal = Vector2()
var start = Vector2()
var startV = Vector2()
var end = Vector2()
var endV = Vector2()
var zoomFactor = 1.0
var zooming = false
var isDragging = false

onready var rectD = $"../UI/Base/drawRect"

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = get_viewport().size.x/2
	position.y = get_viewport().size.y/2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Moving
	var inputX = (int(Input.is_action_pressed("ui_right")) 
	            - int(Input.is_action_pressed("ui_left")))
	var inputY = (int(Input.is_action_pressed("ui_down")) 
	            - int(Input.is_action_pressed("ui_up")))
	
	position.x = lerp(position.x, 
	                  position.x + inputX * speed * zoom.x, 
	                  speed * delta)
	position.y = lerp(position.y, 
	                  position.y + inputY * speed * zoom.y, 
	                  speed * delta)
	
	# Edge panning
	mousePos = get_viewport().get_mouse_position()
	if mousePos.x < marginX:
		position.x = lerp(position.x, position.x - panSpeed * zoom.x, panSpeed * delta)
	elif mousePos.x > OS.window_size.x - marginX:
		position.x = lerp(position.x, position.x + panSpeed * zoom.x, panSpeed * delta)
	if mousePos.y < marginY:
		position.y = lerp(position.y, position.y - panSpeed * zoom.y, panSpeed * delta)
	elif mousePos.y > OS.window_size.y - marginY:
		position.y = lerp(position.y, position.y + panSpeed * zoom.y, panSpeed * delta)
	
	# Zoom in
	zoom.x = lerp(zoom.x, zoom.x * zoomFactor, zoomSpeed * delta)
	zoom.y = lerp(zoom.y, zoom.y * zoomFactor, zoomSpeed * delta)
	
	zoom.x = clamp(zoom.x, zoomMin, zoomMax)
	zoom.y = clamp(zoom.y, zoomMin, zoomMax)
	
	if not zooming:
		zoomFactor = lerp(zoomFactor, 1.0, zoomSmoothing)

# Mouse wheel to scroll
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			zooming = true
			if event.button_index == BUTTON_WHEEL_UP:
				zoomFactor -= 0.01 * zoomSpeed
			elif event.button_index == BUTTON_WHEEL_DOWN:
				zoomFactor += 0.01 * zoomSpeed
		else:
			zooming = false
	
	if event is InputEventMouse:
		mousePos = event.position
		mousePosGlobal= get_global_mouse_position()