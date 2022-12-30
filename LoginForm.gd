extends Control


func _ready():
	pass


func login():
	if $LoginFormFunctionality/LineEdit.text != "":
		get_tree().call_group("Gamestate", "update_username", $LoginFormFunctionality/LineEdit.text)
		queue_free()


func _on_BtnLogin_pressed():
	login()
