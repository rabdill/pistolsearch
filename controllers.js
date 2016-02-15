var app = angular.module('pistolSearch');

app.controller('IndexCtrl', ['$scope', '$rootScope', '$location', 'GUNS', 'UserSearch', 'CRITERIA', function ($scope, $rootScope, $location, GUNS, UserSearch, CRITERIA) {

	$scope.guns = GUNS;
	$scope.criteria = CRITERIA;
	$scope.selections = UserSearch;

	$scope.display = "table";

	$scope.wizard = {
		caliber : {}
	};

	$scope.process = function() {
		// find the selection section for caliber
		var caliberIndex = _.findIndex($scope.criteria.categories, {'field' : 'caliber'});
		for(var i=0; i < $scope.criteria.categories[caliberIndex].members.length; i++) {
			if($scope.wizard.caliber[$scope.criteria.categories[caliberIndex].members[i]]) {
				$scope.selections.categories[caliberIndex][i] = $scope.wizard.caliber[$scope.criteria.categories[caliberIndex].members[i]];
			}
		}
		$location.path('/');
	}
	$scope.checkExclusives = function(category, selection) {
		// (when they come in, "category" and "selection" are array indices.)
		if(CRITERIA.categories[category].exclusive) {
			for(var i=0; i < CRITERIA.categories[category].members.length; i++) {
				// if it's selected but NOT the one the user just selected:
				if($scope.selections.categories[category][i] === 'must' && i !== selection) {
					$scope.selections.categories[category][i] = 'can';
				}
			}
		}
	}

	// the filter
	$scope.masterGun = function(input) {
		// check the categories for disqualifications:
		for(var i=0; i < $scope.selections.categories.length; i++) {
			for(var j=0; j < $scope.selections.categories[i].length; j++) {
				switch($scope.selections.categories[i][j]) {
					case 'must':
						if(input[CRITERIA.categories[i].field] !== CRITERIA.categories[i].members[j]) return false;
						break;
					case 'cant':
						if(input[CRITERIA.categories[i].field] === CRITERIA.categories[i].members[j]) return false;
						break;
				}
			}
		}

		// then check the options:
		for(var i=0; i < $scope.selections.options.length; i++) {
			switch($scope.selections.options[i]) {
				case 'must':
					if(!_.includes(input.options, CRITERIA.options[i].name)) return false;
					break;
				case 'cant':
					if(_.includes(input.options, CRITERIA.options[i].name)) return false;
					break;
			}
		}

		// otherwise let it through:
		return true;
	};

	$scope.reset = function() {
		for(var i=0; i < $scope.selections.categories.length; i++) {
			for(var j=0; j < $scope.selections.categories[i].length; j++) {
				delete $scope.selections.categories[i][j];
			}
		}

		// then check the options:
		for(var i=0; i < $scope.selections.options.length; i++) {
			delete $scope.selections.options[i];
		}
	};
}]);

app.controller('DetailCtrl', ['$scope', '$rootScope', '$routeParams', '$sce', 'GUNS', 'FAMILIES', 'CRITERIA', '_', function ($scope, $rootScope, $routeParams, $sce, GUNS, FAMILIES, CRITERIA, _) {

	$scope.id = $routeParams.id;
	$scope.gun = _.find(GUNS, { 'id': $routeParams.id});

	// find the families that include the current gun:
	var zzz = _.filter(FAMILIES, function(f) {
		return _.includes(f.members, $routeParams.id);
	});

	$scope.families = _.cloneDeep(zzz);
	for(var i=0; i < $scope.families.length; i++) {
		// remove the current gun from the membership list of its groups:
		/*$scope.families[i].members = _.filter($scope.families[i].members, function(m) {
			return m !== $routeParams.id;
		});*/

		// translate gun IDs into actual gun data:
		for(var j=0; j < $scope.families[i].members.length; j++) {
			var id = $scope.families[i].members[j];
			$scope.families[i].members[j] = _.find(GUNS, {"id" : $scope.families[i].members[j]});
		}
	}

	// if it's a variant, search for its siblings, otherwise search for its children
	var variants = {
		"name" : "Variants",
		"members" : _.filter(GUNS, { 'variant': $scope.gun.variant || $scope.gun.id })
	};
	// if it's a variant, add its parent:
	if($scope.gun.variant) variants.members.push(_.find(GUNS, { 'id': $scope.gun.variant }));

	// add the variants (if there are any) to the main list of families:
	if(variants.members.length > 0) $scope.families.push(variants);

	// fix up the youtube embed codes:
	if($scope.gun.youtube) {
		// generate all the YouTube embeds:
		$scope.embed = [];
		for(var i=0, v; v = $scope.gun.youtube[i]; i++) {
			$scope.embed.push($sce.trustAsHtml('<iframe width="560" height="315" src="' + $scope.gun.youtube[i] + '" frameborder="0" allowfullscreen></iframe>'));
		}
	}

	if($scope.gun.amazon) {
		$scope.amazon = [];
		for(var i=0, v; v = $scope.gun.amazon[i]; i++) {
			$scope.amazon.push($sce.trustAsHtml('<iframe style="width:120px;height:240px;" marginwidth="0" marginheight="0" scrolling="no" frameborder="0" src="' + $scope.gun.amazon[i] + '"></iframe>'));
		}
	}

	$scope.details = {
		"Caliber" : $scope.gun.caliber,
		"Frame material" : $scope.gun.frame,
		"Trigger mechanism" : $scope.gun.trigger,
		"Magazine capacity" : $scope.gun.capacity
	};

	$scope.measurementUnits = {
		"barrel" : "in.",
		"overall" : "in.",
		"height" : "in.",
		"width" : "in.",
		"weight" : "oz."
	};

	// fill in the display names of the gun's options:
	$scope.printOptions = [];
	if($scope.gun.options) {
		for(var i=0; i < $scope.gun.options.length; i++) {
			var lookup = _.find(CRITERIA.options, {"name" : $scope.gun.options[i]});
			if(lookup) $scope.printOptions.push(lookup.display);
			else $scope.printOptions.push($scope.gun.options[i]);
		}
	}

}]);
