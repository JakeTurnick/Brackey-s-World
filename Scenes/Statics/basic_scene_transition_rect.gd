extends ColorRect

func PlayFadeIn():
	$AnimationPlayer.play("Fade")
	
func PlayFadeOut():
	$AnimationPlayer.play("FadeBack")

func QueueFadeIn():
	$AnimationPlayer.queue("Fade")
	
func QueueFadeOut():
	$AnimationPlayer.queue("FadeBack")
