class_name Card

var num : int
var house : String # naipe (Ouro, Espadas, Copas e Paus)

var title : String # Eg. "5 de ouros"
var score : int # pontuacao

# Construtor
func _init(num, house):
	self.num = num
	self.house = house 

	if( num == 1 ):
		self.score = 11
		self.title = "Às"
	elif( num > 10 ):
		self.score = 10
		if( num == 11 ):
			self.title = "Valete"
		elif( num == 12 ):
			self.title = "Rainha"
		else:
			self.title = "Rei"
	else:
		self.score = num
		self.title = str(num)
	self.title += " de " + house
