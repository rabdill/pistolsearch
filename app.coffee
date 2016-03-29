app = angular.module 'pistolSearch', [
	'ngRoute'
	'ngAnimate'
	'ngMaterial'
	'gunData'
]


app.config ['$routeProvider', ($routeProvider) ->
	$routeProvider.
		when('/', {
			templateUrl: 'views/main.html',
			controller: 'IndexCtrl'
		}).
		when('/about', {
			templateUrl: 'views/about.html',
		}).
		when('/privacy', {
			templateUrl: 'views/privacy.html',
		}).
		when('/wizard', {
			templateUrl: 'views/wizard.html',
			controller: 'WizardCtrl'
		}).
		when('/:id', {
			templateUrl: 'views/detail.html',
			controller: 'DetailCtrl'
		}).

		otherwise({redirectTo: '/'});
]

app.config ['$httpProvider', ($httpProvider) ->
	$httpProvider.defaults.useXDomain = true
	delete $httpProvider.defaults.headers.common['X-Requested-With'];
]

app.factory "_", ($window) ->
	return $window._
