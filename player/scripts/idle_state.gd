extends State
class_name IdleState

var player

func _ready():
	player = get_parent()
	animation.travel("Idle")

func _physics_process(delta):
	if Input.is_action_pressed("MoveForward") or Input.is_action_pressed("MoveBack") or Input.is_action_pressed("MoveRight") or Input.is_action_pressed("MoveLeft"):
		player.change_state("move")
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.velocity.z = move_toward(player.velocity.z, 0, player.SPEED)

func exit():
	print("exit IdleState")
