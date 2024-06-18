extends RigidBody3D

@export_category("Const")
@export var accel : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("accelerate")):
		apply_central_force(Vector3.FORWARD*20*accel)
	var turnAngle : float = Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")

	pass
