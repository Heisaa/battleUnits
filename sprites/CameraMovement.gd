extends Camera2D

export var speed = 20.0
export var zoomSpeed = 10.0
export var zoomSmoothing = 0.7

export var zoomMin = 0.25
export var zoomMax = 3.0


var zoomPos = Vector2()
var zoomFactor = 1.0
var zooming = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
				zoomPos = get_global_mouse_position()
			elif event.button_index == BUTTON_WHEEL_DOWN:
				zoomFactor += 0.01 * zoomSpeed
				zoomPos = get_global_mouse_position()
		else:
			zooming = false