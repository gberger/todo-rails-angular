angular.module("todoApp")

.controller "UserCtrl", ($scope, User) ->
	$scope.user = User

.controller "LoginCtrl", ($scope, $http, $location, User, API_ENDPOINT) ->
	loginOrSignup = (loc) ->
		$http
			method: 'POST'
			url: API_ENDPOINT + loc
			data: email: $scope.email, password: $scope.password
		.success (data, status, headers, config) ->
			User.isLoggedIn = true
			User.email = data.email
			User.apiKey = data.api_key
			User.apiKeyExpiresAt = data.api_key_expires_at
			$location.path('/home')

	$scope.login = ->
		loginOrSignup('/users/login')

	$scope.signup = ->
		loginOrSignup('/users/signup')


.controller "TodosCtrl", ($scope, $location, Todo) ->
	$scope.sortAttrs = [
		displayName: 'Priority'
		varName: 'priority'
	,
		displayName: 'Due Date'
		varName: 'due_date'
	]

	$scope.fetchTodos = ->
		todos = Todo.query {order: $location.search()['order']}, ->
			for todo in todos when todo.due_date
				[year, month, day] = todo.due_date.split('-')
				todo.due_date = new Date(year, month-1, day)
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

	$scope.isLate = (todo) ->
		!todo.completed && todo.due_date && todo.due_date < new Date()
