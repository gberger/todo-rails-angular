angular.module("todoApp")

.controller "UserCtrl", ($scope, User) ->
	$scope.user = User

	$scope.logout = ->
		$scope.user.logout()


.controller "LoginCtrl", ($scope, $http, $location, User) ->

	callback = ->
		User.toStorage()
		$location.path('/home')

	$scope.login = ->
		User.login($scope.email, $scope.password).success callback

	$scope.signup = ->
		User.signup($scope.email, $scope.password).success callback


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
			$scope.fetchTodos()

	$scope.confirmDelete = (todo) ->
		if confirm('Are you sure you want to delete this todo?')
			todo.$delete ->
				$scope.fetchTodos()

	$scope.isLate = (todo) ->
		!todo.completed && todo.due_date && todo.due_date < new Date()
