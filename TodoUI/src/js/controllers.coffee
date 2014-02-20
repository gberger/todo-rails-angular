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
			$location.path('/home')

	$scope.login = ->
		loginOrSignup('/sessions')

	$scope.signup = ->
		loginOrSignup('/users')


.controller "TodosCtrl", ($scope, $location, Todo) ->
	$scope.fetchTodos = ->
		todos = Todo.query {order: $location.search()['order']}, ->
			$scope.todos = todos
	$scope.fetchTodos()

	$scope.updateTodo = (todo) ->
		todo.$update().then ->
			$scope.fetchTodos()

	$scope.openDatepicker = ($event, todo) ->
		$event.preventDefault()
		$event.stopPropagation()
		todo.datepickerOpened = true

	$scope.newTodo = ->
		todo = new Todo()
		todo.text = $scope.newTodoText
		todo.$save ->
			scope.fetchTodos()

	$scope.confirmDelete = (todo) ->
		if confirm('Are you sure you want to delete this todo?')
			todo.$delete ->
				$scope.fetchTodos()
