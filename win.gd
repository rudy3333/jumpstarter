extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		var img = get_node("TextureRect")  # directly get child TextureRect
		if img:
			img.visible = true
