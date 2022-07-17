class_name StateMachine
extends Node

# Emitted when transitioning to a new state.
signal state_changed(state_name)
signal state_entered(state_name)
signal state_exited(state_name)

# Path to the initial active state. We export it to be able to pick the initial state in the inspector.
export var initial_state = NodePath()

# The current active state. At the start of the game, we get the `initial_state`.
onready var state : State = get_node(initial_state)


func _ready() -> void:
	yield(owner, "ready")
	# The state machine assigns itself to the State objects' state_machine property.
	for child in get_children():
		child.state_machine = self
	state.enter()


# The state machine subscribes to node callbacks and delegates them to the state objects.
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func change(target_state_name: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	state.exit()
	emit_signal("state_exited", state.name)
	state = get_node(target_state_name)
	state.enter(data)
	emit_signal("state_entered", state.name)
	emit_signal("state_changed", state.name)