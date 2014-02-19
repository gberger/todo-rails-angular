angular.module("todoApp")

.controller "LoginCtrl", ($scope, $http, $location, User, API_ENDPOINT) ->
	loginOrSignup = (loc) ->
		$http
			method: 'POST'
			url: API_ENDPOINT + loc
			data: user: email: $scope.email, password: $scope.password
		.success (data, status, headers, config) ->
			User.isLoggedIn = true
			User.email = data.user.email
			User.apiKey = data.api_key.access_token
			$location('/home')

	$scope.login = ->
		loginOrSignup('/users')

	$scope.signup = ->
		loginOrSignup('/sessions')


.controller "TodosCtrl", ($scope, Todo, User) ->
	todos = Todo.query {}, ->
		$scope.todos = todos

.controller "TodoCtrl", ($scope, $routeParams, Todo, User) ->
	$scope.hello = "world"
	$scope.id = $routeParams.id
	todo = Todo.get {id: $routeParams.id}, ->
		$scope.todo = todo

