var app = angular.module('pistolSearch');

app.factory('UserSearch', ['_', 'CRITERIA', function(_, CRITERIA) {
	var self = {};
	// build an empty 2-dimensional array to store choices in the power search:
	self.power = {};
	self.power.categories = _.fill(Array(CRITERIA.categories.length), []);
	for(var i=0; i < self.power.categories.length; i++) {
			self.power.categories[i] = [];
	};
	self.power.options = [];

	// storing choices from the wizard:
	self.wizard = {
		caliber : {}
	};

	return self;
}]);
