angular.module("todoApp")

.controller "UserCtrl", ($scope, $modal, User) ->
	$scope.user = User

	$scope.logout = ->
		$scope.user.logout()

	$scope.openApiKeyModal = ->
		$modal.open
			templateUrl: 'partials/user-api-key.html'
			controller: 'UserApiKeyCtrl'

	$scope.openChangePasswordModal = ->
		$modal.open
			templateUrl: 'partials/user-change-password.html'
			controller: 'UserChangePasswordCtrl'


.controller "UserApiKeyCtrl", ($scope, $modalInstance, $controller, User) ->
	$scope.user = User
	$scope.data = {}

	$scope.close = ->
		$modalInstance.dismiss('close')

	$scope.resetApiKey = ->
		User.resetApiKey($scope.data.password)


.controller "UserChangePasswordCtrl", ($scope, $modalInstance, $controller, User) ->
	$scope.user = User
	$scope.data = {}

	$scope.close = ->
		$modalInstance.dismiss('close')

	$scope.changePassword = ->
		User.changePassword($scope.data.oldPassword, $scope.data.newPassword)


.controller "LoginCtrl", ($scope, $http, $location, User) ->
	loginOrSignupCallback = ->
		User.toStorage()
		$location.path('/home')

	$scope.login = ->
		User.login($scope.email, $scope.password).success loginOrSignupCallback

	$scope.signup = ->
		User.signup($scope.email, $scope.password).success loginOrSignupCallback


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
		$scope.newTodoText = ''
		todo.$save ->
			$scope.fetchTodos()

	$scope.confirmDelete = (todo) ->
		if confirm('Are you sure you want to delete this todo?')
			todo.$delete ->
				$scope.fetchTodos()

	lpad = (value, length) ->
		if (value.toString().length < length) then lpad('0' + value, length) else value

	formatDate = (date) ->
		return date+'' if typeof date == 'string'
		"#{date.getFullYear()}-#{lpad(date.getMonth()+1, 2)}-#{lpad(date.getDate(), 2)}"

	$scope.isLate = (todo) ->
		r = !todo.completed && todo.due_date && formatDate(todo.due_date) < formatDate(new Date())
		console.log todo, formatDate(todo.due_date), formatDate(new Date()), r
		r

	$scope.isToday = (todo) ->
		!todo.completed && todo.due_date && formatDate(todo.due_date) == formatDate(new Date())
