angular.module("todoApp")

.controller "TodosCtrl", ($scope, Todo) ->
	todos = Todo.query {}, ->
		$scope.todos = todos

.controller "TodoCtrl", ($scope, $routeParams, Todo) ->
	$scope.hello = "world"
	$scope.id = $routeParams.id
	todo = Todo.get {id: $routeParams.id}, ->
		$scope.todo = todo

