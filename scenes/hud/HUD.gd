extends CanvasLayer

@onready var life_1 = %Life1
@onready var life_2 = %Life2
@onready var life_3 = %Life3
@onready var score = %Score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score.text = str(GameManager.score)
	life_1.visible = GameManager.lives > 0
	life_2.visible = GameManager.lives > 1
	life_3.visible = GameManager.lives > 2
