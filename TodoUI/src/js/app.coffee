angular.module("todoApp", ["ngRoute", "ngResource"])

.config ($routeProvider, $httpProvider) ->
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

.factory 'TodoAPIInterceptor', ($q, $rootScope, $location, User) ->
		request: (config) ->
			config.headers['AccessToken'] = User.apiKey if User.isLoggedIn
			return config

		responseError: (rejection) ->
			switch rejection.status
				when 401
					$location.path '/login'

			$q.reject rejection
