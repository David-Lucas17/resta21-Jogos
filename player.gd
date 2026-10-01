class_name Player

var hand = []
var score : int = 0
var title : String

func _init(title):
	self.title = title

func show_hand():
	var text = ''
	for card in self.hand:
		text += card.title + ' | '
	return text

func take_card( deck ):
	self.hand.append( deck[0] )
	self.score += deck[0].score
	deck.remove_at( 0 )
