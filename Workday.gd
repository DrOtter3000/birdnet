extends Control


export (PackedScene) var Message = preload("res://Message.tscn")
var score = 0
var hours_worked = 0
var revisions = 0
var revision_target = 10


func _ready():
	$MessageTimer.start()
	$HourTimer.start()
	set_daytime()
	update_revisions()
	$Sidebar/NinePatchRect/VBoxContainer/LblRevisionsDone.text = ""
	$Sidebar/ControlBox/BtnBan.visible = false


func _process(delta):
	check_if_finish()


func update_message(direction):
	get_tree().call_group("Message", "button_function", direction)


func check_if_finish():
	if hours_worked == 9:
		print("Finish")


func update_stats(points):
	$MessageTimer.start()
	score += points
	revisions += 1
	update_revisions()


func update_revisions():
	if revisions >= revision_target:
		$Sidebar/NinePatchRect/VBoxContainer/LblRevisionsDone.text = "done"
	$Sidebar/NinePatchRect/VBoxContainer/LblRevisionsCounter.text = str(revisions) + " / " + str(revision_target)


func _on_MessageTimer_timeout():
	var new_message = Message.instance()
	add_child(new_message)


#Daytime is defined here
func _on_HourTimer_timeout():
	$HourTimer.start()
	hours_worked += 1
	set_daytime()


func set_daytime():
	if hours_worked < 4:
		$Sidebar/NinePatchRect/LblTime.text = str(hours_worked + 8) + "am"
	elif hours_worked == 4:
		$Sidebar/NinePatchRect/LblTime.text = "12pm"
	else:
		$Sidebar/NinePatchRect/LblTime.text = str(hours_worked - 4 ) + "pm"


func _on_BtnDelete_pressed():
	update_message("left")


func _on_BtnPass_pressed():
	update_message("right")
