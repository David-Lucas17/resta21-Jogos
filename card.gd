class_name Card

var num : int
var house : String

var title : String
var score : int

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
