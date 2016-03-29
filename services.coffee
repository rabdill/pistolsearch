app = angular.module 'pistolSearch'

app.factory 'UserSearch', ['_', 'CRITERIA', (_, CRITERIA) ->
	self = {};
	# build an empty 2-dimensional array to store choices in the power search:
	self.power =
		categories: [
			[]
			[]
			[]
			[]
		]
		options: []
	###
		NOTE: self.power.categories is set up this way instead of using _.fill() because
		the switch to Coffeescript ruined everything about that. For some reason, every
		array in the "categories" array was a reference to the SAME array, so changing
		choice 1 in category 1 changed choice 1 in every category. This was not the case
		in JS, somehow.
	###
	# storing choices from the wizard:
	self.wizard =
		caliber : {}

	return self;
]
