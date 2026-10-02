extends Node2D

@onready var board = get_node('board')

const MACHINE_STANDS = 17

var turn_player : bool = true
var game_over : bool = false
var playerA : Player
var playerB : Player
var deck

func update_board():
	if( turn_player ):
		board.text = 'Vez do jogador ' + str(playerA.title)
	else:
		board.text = 'Vez do jogador ' + str(playerB.title)
	board.text += ' | ' + str(playerA.title) + ': ' + str( playerA.score )
	board.text += ' | ' + str(playerB.title) + ': ' + str( playerB.score )
	board.text += '\n'
	board.text += playerA.show_hand() + '\n' + playerB.show_hand()

func check_winner():
	if( playerA.score > 21 ):
		$resultLabel.text = playerA.title + " passou de 21. " + playerB.title + " venceu."
		game_over = true
	elif( playerB.score > 21 ):
		$resultLabel.text = playerB.title + " passou de 21. " + playerA.title + " venceu."
		game_over = true
	elif( playerA.score == 21 ):
		$resultLabel.text = "Jogador " + playerA.title + " venceu."
		game_over = true
	elif( playerB.score == 21 ):
		$resultLabel.text = "Jogador " + playerB.title + " venceu."
		game_over = true
	return game_over

func machine_plays():
	turn_player = false
	update_board()

	while( playerB.score < MACHINE_STANDS ):
		playerB.take_card( deck )
		update_board()
		if check_winner():
			return

	turn_player = true
	update_board()

func compare_scores():
	if( playerA.score > playerB.score ):
		$resultLabel.text = playerA.title + " venceu por " + str(playerA.score) + " a " + str(playerB.score) + "."
	elif( playerB.score > playerA.score ):
		$resultLabel.text = playerB.title + " venceu por " + str(playerB.score) + " a " + str(playerA.score) + "."
	else:
		$resultLabel.text = "Empate em " + str(playerA.score) + "."
	game_over = true

func generate_deck():
	var deck = []

	var houses = ["Ouro", "Copas", "Espadas", "Paus"]
	for house in houses:
		for num in range(1, 14):
			deck.append( Card.new( num, house ) )
	return deck

func _ready():
	playerA = Player.new("Joaw")
	playerB = Player.new("Warya")

	deck = generate_deck()
	deck.shuffle()

	update_board()

func _on_btn_pull_button_up() -> void:
	if( game_over ):
		return

	playerA.take_card( deck )
	update_board()

	if check_winner():
		return

	machine_plays()

func _on_btn_keep_button_up() -> void:
	if( game_over ):
		return

	machine_plays()

	if( game_over ):
		return

	compare_scores()

func _on_btn_reset_button_up() -> void:
	playerA.hand = []
	playerB.hand = []

	playerA.score = 0
	playerB.score = 0

	deck = generate_deck()
	deck.shuffle()

	turn_player = true
	game_over = false
	$resultLabel.text = ""
	update_board()
