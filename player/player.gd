extends CharacterBody3D

@onready var anim_tree = get_node("AnimationTree")
@onready var playback = anim_tree.get("parameters/playback")
@onready var player_mesh = get_node("KayKit_AnimatedCharacter_v1_2")

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# State Variables
var state
var state_factory
var direction

func _ready():
	state_factory = StateFactory.new()
	change_state("idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		playback.travel("Jump")

	var h_rot = $CameraController.transform.basis.get_euler().y

	direction = Vector3(Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft"), 0, Input.get_action_strength("MoveBack") - Input.get_action_strength("MoveForward"))
	direction = direction.rotated(Vector3.UP, h_rot).normalized()
	
	move_and_slide()

func change_state(new_state_name):
	if state != null:
		state.exit()
		state.queue_free()
	# Add New State
	state = state_factory.get_state(new_state_name).new()
	state.setup("change_state", playback, self)
	state.name = new_state_name
	add_child(state)
