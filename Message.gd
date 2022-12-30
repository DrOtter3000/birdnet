extends Node2D


const SPEED = 50
var points = 1
var direction = "none"
var fraud = false
var names = ["Hans Gruber", "Dolum Trum", "Deeznuz", "fr34k", "G4n9573r", "lurkmaster",
		"Bob Kelzo", "Yo$hi", "Tucks the Limux-pengoin", "Boomer", "Homler Simson",
		"420life"]
var usernames = ["hansgruber", "dolumtrum", "deeznuz", "fr34k", "g4n9573r",
		"lurkmaster", "bobkelzo", "yoshi", "tucks", "boomer", "420life"]
var random_thingy_list = ["WaldomirPoutine", "BadstreetBoys", "TheSmurfs", 
		"darknet-online.com", "Furries", "DrOtter3000", "thisCuteBoy", 
		"thisCuteGirl", "punkrock", "gothic", "gothics", "EBM", "doggos", "kittens",
		"muffins", "TheBeatles", "Picasso", "Beethoven", "ErnstBusch", "Hans"]
var random_location_list = ["UK", "Germany", "USA", "Australia", "Vietnam",
		"my bedroom", "North Korea", "my wardrobe", "my bed", "my fathers house",
		"my mothers house"]
var list_of_past_words = ["yesterday", "a couple of days ago", "today", "last week",
		"last year", "this week", "earlier"]


func _ready():
	randomize()
	$VBoxContainer/LblUserName.text = generate_user_name()
	$VBoxContainer/LblMessage.text = generate_normal_message()
	generate_statistics()


func _process(delta):
	check_for_input()
	move(direction)
	check_if_alive()


func check_if_alive():
	if position.x < -1200 or position.x > 1200:
		get_tree().call_group("Workday", "update_stats", points)
		queue_free()


func button_function(btn_direction):
	if btn_direction == ("right"):
		if fraud == true:
			points *= -1
	if btn_direction == ("left"):
		if fraud == false:
			points *= -1
	direction = btn_direction


func check_for_input():
	if Input.is_action_just_pressed("left"):
		direction = "left"
		if fraud == false:
			points *= -1
	if Input.is_action_just_pressed("right"):
		direction = "right"
		if fraud == true:
			points *= -1


func move(direction):
	if direction == "left":
		position -= Vector2(SPEED, 0)
	elif direction == "right":
		position += Vector2(SPEED, 0)


func generate_user_name():
	var name = names[randi() % names.size()] 
	var username = usernames[randi() % usernames.size()]
	return(name + " @" + username + "\n")


func generate_normal_message():
	var random_hashtag_1 = random_hashtag()
	var random_hashtag_2 = random_hashtag()
	var random_hashtag_3 = random_hashtag()
	var random_thingy = random_thingy_list[randi() % random_thingy_list.size()]
	var random_location = random_location_list[randi() % random_location_list.size()]
	var some_time_in_past = list_of_past_words[randi() % list_of_past_words.size()]
	var normal_messages_part_1 = ["", "Oh boy, ", "Hey guys, ", "WTF??? ", "lol ", 
			"Heard about? ", "Comrades, ", "Fellow humans, ", "awww... ", "idk ",
			"ROFL!!! ", ":P ", "UwU ", "OwO ", "uwu ", "owo ", "God damn! ", "Fuck ",
			"Folks, listen: ", ""]
	var normal_messages_part_2 = ["I damn hate " + "#" + random_thingy + " so much. ", 
			"Was so nice with " + "#" + random_thingy + " " + some_time_in_past + ". ",
			"Why is there " + "#" + random_thingy + " in " + random_hashtag_1 + random_location + "? ",
			"The weather is great! ", some_time_in_past + ", is there more to say? "]
	var normal_messages_part_3 = ["", "Trust me.", "You can't believe!", 
			"Don't know how to tell", "AAARGH!!!", "You know what I mean ;)", 
			"#savetf2", "Can you believe?", "But... why?", "You can't imagine...",
			"But next time I know what to do!", "Isn't it?", "Everyone says so",
			"#Multipass", ""]
	return(normal_messages_part_1[randi() % normal_messages_part_1.size()] + 
			normal_messages_part_2[randi() % normal_messages_part_2.size()] + 
			normal_messages_part_3[randi() % normal_messages_part_3.size()])


func random_hashtag():
	var set_hashtag = randi() % 2
	var decision = ""
	if set_hashtag == 0:
		decision = "#"
	return(decision)


func generate_statistics():
	var initial_randomizer = randi() % 100
	var max_value = 0
	if initial_randomizer <= 80:
		max_value = 10
	elif initial_randomizer <= 90:
		max_value = 100
	elif initial_randomizer <= 95:
		max_value = 1000
	elif initial_randomizer <= 98:
		max_value = 10000
	else:
		max_value = 100000
	
	var views = randi() % (max_value*100)
	var favs = randi() % (max_value*10)
	var boosts = randi() % max_value
	if favs > views:
		while favs >= views:
			favs = randi() % (max_value*7)
	if boosts > views:
		while boosts >= views:
			favs = randi() % max_value
	
	$HBoxContainer/LblViews.text = "Views: " + str(views)
	$HBoxContainer/LblBoosts.text = "Favs: " + str(favs)
	$HBoxContainer/LblRepeats.text = "Boosts: " + str(boosts)

