extends Level


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.space_level = true
	#ScreenShaders.crt_effect
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _exit_tree() -> void:
	print("exited_tree")
	Globals.space_level = false
