extends Node2D

@onready var board = get_node('board')

# logica
var turn_player : bool = true
var playerA : Player
var playerB : Player
var deck

func update_turn():
	turn_player = not turn_player
	
	if( turn_player ):
		board.text = 'Vez do jogador ' + str(playerA.title)
	else:
		board.text = 'Vez do jogador ' + str(playerB.title)
	board.text += ' | ' + str(playerA.title) + ': ' + str( playerA.score )
	board.text += ' | ' + str(playerB.title) + ': ' + str( playerB.score )
	board.text += '\n'
	board.text += playerA.show_hand() + '\n' + playerB.show_hand()
	
	if not turn_player:
		playerB.take_card(deck)
		update_turn()

func generate_deck():
	var deck = []
	# naipes = "houses"
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
	
	for temporaria in deck:
		# print( str( temporaria.num ) + ' de ' + temporaria.house )
		print( temporaria.title )


func _on_btn_pull_button_up() -> void:
	if( turn_player ):
		playerA.take_card( deck )
	else:
		playerB.take_card( deck )
	
	if( playerA.score == 21 or playerB.score > 21 ):
		$resultLabel.text = "Jogador " + playerA.title + " venceu."
	elif( playerB.score == 21 or playerA.score > 21 ): # else if
		$resultLabel.text = "Jogador " + playerB.title + " venceu."
	update_turn()

func _on_btn_keep_button_up() -> void:
	update_turn()
	board.text += "Manteve carta"
	

func _on_btn_reset_button_up() -> void:
	#board.text = "Reiniciar"
	playerA.hand = []
	playerB.hand = []
	
	playerA.score = 0
	playerB.score = 0

	deck = generate_deck()
	deck.shuffle()
	
	turn_player = true
	update_turn()
	$resultLabel.text = ""
