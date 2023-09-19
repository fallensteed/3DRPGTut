extends State
class_name AttackState

var player

func _ready():
	player = get_parent()
	attackAnimation()
	player.velocity.x = 0
	player.velocity.z = 0
	
func attackAnimation():
	animation.travel("Attack(1h)")
	
func _physics_process(delta):
	pass

func exit():
	pass
