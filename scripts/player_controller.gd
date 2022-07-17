extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var character_speed = 5
var velocity = Vector3()
var rotationSpeed = 3
var rotationDirection = 0
var animator

# Called when the node enters the scene tree for the first time.
func _ready():
    animator = $ANI_DiceBoy_IdleHappy/AnimationPlayer
    # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

# Physics body processing
func _physics_process(delta):
    velocity.x = 0
    velocity.z = 0
    rotationDirection = 0

    var input = Vector3()
    if Input.is_action_pressed("move_forward"):
        input.z += 1
    if Input.is_action_pressed("move_backward"):
        input.z -= 1
 #   if Input.is_action_pressed("move_left"):
 #       input.x += 1
 #   if Input.is_action_pressed("move_right"):
 #       input.x -= 1
    # Rotate the character if pressing left or right
    if Input.is_action_pressed("move_left"):
        rotationDirection += 1
    if Input.is_action_pressed("move_right"):
        rotationDirection -= 1

    if input.length_squared() == 0.0:
        animator.play("Armature|mixamocom|Layer0001")
    else:
        animator.play("Armature|mixamocom|Layer0")

    input = input.normalized()

    $ANI_DiceBoy_IdleHappy.rotate_object_local(Vector3.UP, rotationDirection * rotationSpeed * delta)
    var direction = ($ANI_DiceBoy_IdleHappy.transform.basis.z * input.z + $ANI_DiceBoy_IdleHappy.transform.basis.x * input.x)
    
    velocity.x = direction.x * character_speed
    velocity.z = direction.z * character_speed

    velocity = move_and_slide(velocity, Vector3.UP)
