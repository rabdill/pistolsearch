app = angular.module('pistolSearch', [
	'ngRoute',
	'ngAnimate',
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
