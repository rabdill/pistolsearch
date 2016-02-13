var app = angular.module('pistolSearch');

app.factory('UserSearch', ['_', 'CRITERIA', function(_, CRITERIA) {
	// build an empty 2-dimensional array to store choices:
	var x = {};
	x.categories = _.fill(Array(CRITERIA.categories.length), []);

	for(var i=0; i < x.categories.length; i++) {
			x.categories[i] = [];
	};

	x.options = [];
	
	return x;
}]);
