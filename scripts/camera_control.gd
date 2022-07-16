extends Spatial

var rotationSpeed = 0.01
var holding_world_button = false
var zoom_speed = 0.09
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    #Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
    Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# For mouse input
func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == BUTTON_LEFT and event.is_pressed():
            #var movement = event.relative
            Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
            holding_world_button = true
        elif event.button_index == BUTTON_LEFT and not event.is_pressed():
            holding_world_button = false
            #Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
            Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
        elif event.button_index == BUTTON_WHEEL_UP:
            $InnerGimbal/Camera.translate_object_local(Vector3.FORWARD * lerp(0, 1, zoom_speed))
        elif event.button_index == BUTTON_WHEEL_DOWN:
            $InnerGimbal/Camera.translate_object_local(-Vector3.FORWARD * lerp(0, 1, zoom_speed))
    if event is InputEventMouseMotion:
        if holding_world_button:
            # We are holding the mouse down and moving the mouse
            # use this to rotate the camera around the center
            transform = transform.orthonormalized()
            $InnerGimbal.transform = $InnerGimbal.transform.orthonormalized()
            transform = transform.rotated(transform.basis.y, (rotationSpeed * event.relative.x))
            $InnerGimbal.transform = $InnerGimbal.transform.rotated($InnerGimbal.transform.basis.x, rotationSpeed * event.relative.y)
            if $InnerGimbal.rotation_degrees.x > 75:
                $InnerGimbal.rotation_degrees.x = 75
            if $InnerGimbal.rotation_degrees.x < -45:
                $InnerGimbal.rotation_degrees.x = -45
            #$InnerGimbal.set_rotation(Vector3(clamp($InnerGimbal.rotation_degrees.x, -45, 45), 0, 0))
            #$Camera.transform.basis = $Camera.transform.basis.rotated($Camera.transform.basis.x, (rotationSpeed * event.relative.y))
            #$Camera.transform.basis = Basis($Camera.transform.basis.x,
            #                                $Camera.transform.basis.y + Vector3(0, rotationSpeed * event.relative.y, 0),
            #                                $Camera.transform.basis.z)
            #transform.basis = transform.basis.rotated(transform.basis.z, (rotationSpeed * event.relative.y))        
