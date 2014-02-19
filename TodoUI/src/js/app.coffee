angular.module("todoApp", ["ngRoute", "ngResource", "ngAnimate", "angular-growl"])

.config ($routeProvider, $httpProvider, growlProvider) ->
	$httpProvider.interceptors.push 'TodoAPIInterceptor'

	$routeProvider.when "/login",
		templateUrl: "partials/login.html"
		controller: "LoginCtrl"

	$routeProvider.when '/home',
		redirectTo: '/todos'

	$routeProvider.when "/todos",
		templateUrl: "partials/todos.html"
		controller: "TodosCtrl"

	$routeProvider.when "/todos/:id",
		templateUrl: "partials/todo.html"
		controller: "TodoCtrl"

	$routeProvider.otherwise redirectTo: "/todos"

	$httpProvider.responseInterceptors.push(growlProvider.serverMessagesInterceptor);
	growlProvider.globalTimeToLive(5000)

.factory 'TodoAPIInterceptor', ($q, $rootScope, $location, User, growl) ->
		request: (config) ->
			config.headers['AccessToken'] = User.apiKey if User.isLoggedIn
			return config

		responseError: (rejection) ->
			switch rejection.status
				when 401
					growl.addWarnMessage('Please login.')
					$location.path '/login'

			$q.reject rejection
