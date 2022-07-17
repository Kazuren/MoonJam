extends Sprite


var level_id: int = 0
var id = 0

onready var area = $Area2D


func _ready() -> void:
	area.connect("body_entered", self, "_on_Area_body_entered")


func _process(delta: float) -> void:
	rotation += TAU / 32 * delta


func _on_Area_body_entered(body: Node) -> void:
	if body is Player:
		Globals.coins += 1
		Globals.collect_coin(level_id, id)
		Globals.save_data()
		queue_free()
