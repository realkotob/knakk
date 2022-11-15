extends Control


var score:
	set(value):
		score = value
		$Reward.reward = Reward.Points.new(score)


func _ready():
	score = 100
	$Reward.color = ColorPalette.PURPLE

	var _err = Events.receive_reward.connect(_on_receive_reward)


func _on_receive_reward(reward: Reward):
	if reward is Reward.Points:
		score += reward.points
