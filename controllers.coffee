app = angular.module 'pistolSearch'

app.controller 'IndexCtrl', ['$scope', '$rootScope', '$location', 'GUNS', 'UserSearch', 'CRITERIA', 'PRINTING', '$mdSidenav', '$mdDialog', ($scope, $rootScope, $location, GUNS, UserSearch, CRITERIA, PRINTING, $mdSidenav, $mdDialog) =>
	$scope.showTabDialog = (gun) =>
		$scope.gun = _.find GUNS, { 'id': gun }
		$mdDialog.show({
			controller: 'DetailModalCtrl',
			templateUrl: 'views/detail_dialog.html'
			parent: angular.element(document.body)
			clickOutsideToClose: true
			locals: { gun: $scope.gun }
		})

	$scope.guns = GUNS;
	$scope.criteria = CRITERIA;
	$scope.printing = PRINTING;
	$scope.selections = UserSearch.power;
	$scope.wizard = UserSearch.wizard;

	$scope.display = "table";

	$scope.process = do ->
		# find the selection section for caliber
		caliberIndex = _.findIndex $scope.criteria.categories, {'field' : 'caliber'}

		for member, index in $scope.criteria.categories[caliberIndex].members
			$scope.selections.categories[caliberIndex][index] = $scope.wizard.caliber[member] if $scope.wizard.caliber[member]?

		$location.path('/');

	$scope.checkExclusives = (category, selection) ->
		# (when they come in, "category" and "selection" are array indices.)
		if CRITERIA.categories[category].exclusive
			for member, index in CRITERIA.categories[category].members
				# if it's selected but NOT the one the user just selected:
				if $scope.selections.categories[category][index] == 'must' and index isnt selection
					$scope.selections.categories[category][index] = 'can'

	# the filter
	$scope.masterGun = (input) ->
		# check the categories for disqualifications:
		for category, index in $scope.selections.categories
			for two, index2 in category
				switch two
					when 'must'
						return false if input[CRITERIA.categories[index].field] != CRITERIA.categories[index].members[index2]
					when 'cant'
						return false if input[CRITERIA.categories[index].field] == CRITERIA.categories[index].members[index2]

		# then check the options:
		for option, index in $scope.selections.options
			switch option
				when 'must'
					return false if not _.includes input.options, PRINTING.options[index].name
				when 'cant'
					return false if _.includes input.options, PRINTING.options[index].name

		# otherwise let it through:
		return true

	$scope.reset =->
		for category, index in $scope.selections.categories
			for two, index2 in category
				delete category[index2];

		# reset options too
		delete $scope.selections.options[index] for option, index in $scope.selections.options
]

app.controller 'WizardCtrl', ['$scope', '$rootScope', '$location', '$sce', 'GUNS', 'UserSearch', 'CRITERIA', 'WIZARD', ($scope, $rootScope, $location, $sce, GUNS, UserSearch, CRITERIA, WIZARD) ->
	$scope.wizard = UserSearch.wizard

	$scope.currentPrompt = 0
	prompts = WIZARD.caliberPrompts
	$scope.started = false

	$scope.startWizard = -> $scope.started = true

	# iterate through all the prompts and tell angular it's cool to parse them as HTML:
	###
	conditional added here to make sure we don't process the description twice;
	trying to run $sce.trustAs on something that's already been run through it
	throws a janky error.
	###
	prompt.description = $sce.trustAsHtml p.description for prompt in prompts when typeof prompt.description == 'string'

	$scope.prompt = prompts[$scope.currentPrompt];

	$scope.choice = (cal, decision) ->
		$scope.wizard.caliber[cal] = decision
		$scope.currentPrompt++
		if $scope.currentPrompt < prompts.length
			$scope.prompt = prompts[$scope.currentPrompt]
		else
			delete $scope.prompt
]

app.controller 'DetailCtrl', ['$scope', '$rootScope', '$routeParams', 'GUNS', 'PRINTING', '_', ($scope, $rootScope, $routeParams, GUNS, PRINTING, _) ->
	$scope.gun = _.find GUNS, { 'id': $routeParams.id}
	$scope.details = PRINTING.detailPairs
	$scope.measurementUnits = PRINTING.measurementUnits
]

app.controller 'DetailModalCtrl', ['$scope', '$rootScope', '$routeParams', 'GUNS', 'FAMILIES', 'PRINTING', '_', '$mdDialog', 'gun', ($scope, $rootScope, $routeParams, GUNS, FAMILIES, PRINTING, _, $mdDialog, gun) ->
	# NOTE: The 'gun' parameter is injected by the initialization function
	# in IndexCtrl. It's passed from that controller into here so we can display the gun.
	$scope.gun = gun
	$scope.hide = -> $mdDialog.hide();

	$scope.cancel = -> $mdDialog.cancel()

	$scope.answer = (answer) -> $mdDialog.hide answer

	$scope.details = PRINTING.detailPairs
	$scope.measurementUnits = PRINTING.measurementUnits
]
