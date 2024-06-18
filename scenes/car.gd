extends RigidBody3D

@export_category("Const")
@export var accel : float = 1
@onready var fr_tire = get_node("fr_tire")
@onready var fl_tire = get_node("fl_tire")
@onready var br_tire = get_node("br_tire")
@onready var bl_tire = get_node("bl_tire")
var tireDist
var maxAngle = 40
var decay = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	tireDist = (br_tire.get_position() - fr_tire.get_position()).z
	print(tireDist)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("accelerate")):
		apply_central_force(Vector3.FORWARD*20*accel)
	var turnVal : float = Input.get_action_strength("turn_right") - Input.get_action_strength("turn_left")
	var turnAngle = turnVal*50
	if(abs(turnAngle) > maxAngle):
		turnAngle = 40 * sign(turnVal)
	var leftAngle
	var rightAngle
	if (turnAngle != 0):
		var turnCircCent = tireDist*tan(deg_to_rad(90-abs(turnAngle)))
		leftAngle = (PI/2-(atan2(fl_tire.get_position().x * -sign(turnAngle) + turnCircCent, tireDist))) * -sign(turnAngle)
		rightAngle = (PI/2-(atan2(fr_tire.get_position().x * -sign(turnAngle) + turnCircCent, tireDist))) * -sign(turnAngle)
		print(leftAngle)
	else:
		leftAngle = 0
		rightAngle = 0
	fl_tire.set_rotation(Vector3(0, leftAngle + (fl_tire.get_rotation().y-leftAngle) * exp(-decay*delta), 0))
	fr_tire.set_rotation(Vector3(0, rightAngle + (fr_tire.get_rotation().y-rightAngle) * exp(-decay*delta), 0))

	pass
