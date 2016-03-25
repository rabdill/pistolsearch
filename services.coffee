app = angular.module 'pistolSearch'

app.factory 'UserSearch', ['_', 'CRITERIA', (_, CRITERIA) ->
	self = {};
	# build an empty 2-dimensional array to store choices in the power search:
	self.power =
		categories: _.fill Array(CRITERIA.categories.length), []
		options: []

	cat = [] for cat in self.power.categories

	# storing choices from the wizard:
	self.wizard =
		caliber : {}

	return self;
]
