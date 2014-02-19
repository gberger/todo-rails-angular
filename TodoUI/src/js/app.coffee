angular.module("todoApp", ["ngRoute", "ngResource"])

.config ($routeProvider, $httpProvider) ->
	$httpProvider.interceptors.push 'TodoAPIInterceptor'

	$routeProvider.when "/todos",
		templateUrl: "partials/todos.html"
		controller: "TodosCtrl"

	$routeProvider.when "/todos/:id",
		templateUrl: "partials/todo.html"
		controller: "TodoCtrl"

	$routeProvider.when "/login",
		templateUrl: "partials/login.html"
		controller: "LoginCtrl"

	$routeProvider.otherwise redirectTo: "/todos"

.factory 'TodoAPIInterceptor', ($q, $rootScope, User) ->
		request: (config) ->
			config.headers['AccessToken'] = User.apiKey
			return config
