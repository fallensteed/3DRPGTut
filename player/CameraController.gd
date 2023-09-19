extends Node3D

@export var sensitivity = 5
@onready var spring_arm = get_node("SpringArm3D")

var max_zoom = 10.0
var min_zoom = 2.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta):
	global_position = $"..".global_position

func _input(event):
	if event is InputEventMouseMotion:
		var xRot = clamp(rotation.x - event.relative.y / 1000 * sensitivity, deg_to_rad(-30.0), deg_to_rad(10.0))
		var yRot = rotation.y - event.relative.x / 1000 * sensitivity
		rotation = Vector3(xRot, yRot, 0)
	
	if event is InputEventMouseButton:
		if event.button_index == 4 and spring_arm.spring_length > min_zoom:
			spring_arm.spring_length -= 0.1
		if event.button_index == 5 and spring_arm.spring_length < max_zoom:
			spring_arm.spring_length += 0.1
