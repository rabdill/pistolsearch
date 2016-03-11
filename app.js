app = angular.module('pistolSearch', [
	'ngRoute',
	'ngAnimate',
	'gunData',
]);


app.config(['$routeProvider', function($routeProvider) {
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
}]);

app.config(['$httpProvider', function($httpProvider) {
	$httpProvider.defaults.useXDomain = true;
	delete $httpProvider.defaults.headers.common['X-Requested-With'];
}]);

app.factory("_", function( $window ) {
	return $window._;
});
