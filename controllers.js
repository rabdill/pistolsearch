var app = angular.module('pistolSearch');

app.controller('IndexCtrl', ['$scope', '$rootScope', '$location', 'GUNS', 'UserSearch', 'CRITERIA', 'PRINTING', '$mdSidenav', '$mdDialog', function ($scope, $rootScope, $location, GUNS, UserSearch, CRITERIA, PRINTING, $mdSidenav, $mdDialog) {

	$scope.showTabDialog = function(gun) {
		$scope.gun = _.find(GUNS, { 'id': gun});
    $mdDialog.show({
			controller: 'DetailModalCtrl',
      templateUrl: 'views/detail_dialog.html',
      parent: angular.element(document.body),
      clickOutsideToClose:true,
			locals: { gun: $scope.gun }
    });
  };

	$scope.guns = GUNS;
	$scope.criteria = CRITERIA;
	$scope.printing = PRINTING;
	$scope.selections = UserSearch.power;
	$scope.wizard = UserSearch.wizard;

	$scope.display = "table";

	$scope.process = function() {
		// find the selection section for caliber
		var caliberIndex = _.findIndex($scope.criteria.categories, {'field' : 'caliber'});
		for(var i=0; i < $scope.criteria.categories[caliberIndex].members.length; i++) {
			if($scope.wizard.caliber[$scope.criteria.categories[caliberIndex].members[i]]) {
				$scope.selections.categories[caliberIndex][i] = $scope.wizard.caliber[$scope.criteria.categories[caliberIndex].members[i]];
			}
		}
		$location.path('/');
	}();
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
					if(!_.includes(input.options, PRINTING.options[i].name)) return false;
					break;
				case 'cant':
					if(_.includes(input.options, PRINTING.options[i].name)) return false;
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

app.controller('WizardCtrl', ['$scope', '$rootScope', '$location', '$sce', 'GUNS', 'UserSearch', 'CRITERIA', 'WIZARD', function ($scope, $rootScope, $location, $sce, GUNS, UserSearch, CRITERIA, WIZARD) {
	$scope.wizard = UserSearch.wizard;

	$scope.currentPrompt = 0;
	var prompts = WIZARD.caliberPrompts;
	$scope.started = false;

	$scope.startWizard = function() {
		$scope.started = true;
	};

	// iterate through all the prompts and tell angular it's cool to parse them as HTML:
	_.forEach(prompts, function(p) {
		// conditional added here to make sure we don't process the description twice;
		// trying to run $sce.trustAs on something that's already been run through it
		// throws a janky error.
		if(typeof p.description === 'string') {
			p.description = $sce.trustAsHtml(p.description);
		}
	});

	$scope.prompt = prompts[$scope.currentPrompt];

	$scope.choice = function(cal, decision) {
		$scope.wizard.caliber[cal] = decision;
		$scope.currentPrompt++;
		if($scope.currentPrompt < prompts.length) {
			$scope.prompt = prompts[$scope.currentPrompt];
		}
		else {
			delete $scope.prompt;
		}
	};
}]);

app.controller('DetailCtrl', ['$scope', '$rootScope', '$routeParams', 'GUNS', 'PRINTING', '_', function ($scope, $rootScope, $routeParams, GUNS, PRINTING, _) {
	$scope.gun = _.find(GUNS, { 'id': $routeParams.id});
	$scope.details = PRINTING.detailPairs;
	$scope.measurementUnits = PRINTING.measurementUnits;
}]);

app.controller('DetailModalCtrl', ['$scope', '$rootScope', '$routeParams', 'GUNS', 'FAMILIES', 'PRINTING', '_', '$mdDialog', 'gun', function ($scope, $rootScope, $routeParams, GUNS, FAMILIES, PRINTING, _, $mdDialog, gun) {
	// NOTE: The 'gun' parameter is injected by the initialization function
	// in IndexCtrl. It's passed from that controller into here so we can display the gun.
	$scope.gun = gun;
	$scope.hide = function() {
    $mdDialog.hide();
  };
  $scope.cancel = function() {
    $mdDialog.cancel();
  };
  $scope.answer = function(answer) {
    $mdDialog.hide(answer);
  };

	$scope.details = PRINTING.detailPairs;
	$scope.measurementUnits = PRINTING.measurementUnits;

}]);
