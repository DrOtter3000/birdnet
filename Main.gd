extends Control


export (PackedScene) var LoginWindow = preload("res://LoginForm.tscn")
export (PackedScene) var NextWorkday = preload("res://Workday.tscn")
var username = ""
var money = 0
var days_of_work = 0


func _ready():
	var new_LoginWindow = LoginWindow.instance()
	add_child(new_LoginWindow)


func update_username(name):
	username = name
	print(username)
	start_workday()


func start_workday():
	var new_workday = NextWorkday.instance()
	add_child(new_workday)
