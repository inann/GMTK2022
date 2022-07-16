extends CSGBox


# Member Variables
var rotation_duration = 0.7
var elapsed_time = 0
var currently_rotating = false
var current_rotation = null

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Handle key presses
func _input(event):
    if not currently_rotating:
        if event is InputEventKey:
            if event.scancode == KEY_W:
                # Rotate the die backward along its x axis
                currently_rotating = true
                current_rotation = transform.basis.rotated(Vector3.RIGHT, deg2rad(-90))
            elif event.scancode == KEY_S:
                currently_rotating = true
                current_rotation = transform.basis.rotated(Vector3.RIGHT, deg2rad(90))
            elif event.scancode == KEY_A:
               currently_rotating = true
               current_rotation = transform.basis.rotated(Vector3.FORWARD, deg2rad(-90))
            elif event.scancode == KEY_D:
               currently_rotating = true
               current_rotation = transform.basis.rotated(Vector3.FORWARD, deg2rad(90))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if currently_rotating:
        if (elapsed_time < rotation_duration) and (current_rotation):
            elapsed_time += delta
            transform.basis = transform.basis.slerp(current_rotation, elapsed_time / rotation_duration)
        elif elapsed_time >= rotation_duration:
            elapsed_time = 0
            currently_rotating = false
