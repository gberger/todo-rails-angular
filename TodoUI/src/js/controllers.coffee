angular.module("todoApp")

.controller "TodosCtrl", ($scope, Todo) ->
	$scope.hello = "hi"

.controller "TodoCtrl", ($scope, $routeParams, Todo) ->
	$scope.hello = "world"
	$scope.id = $routeParams.id
	todo = Todo.get {id: $routeParams.id}, ->
		$scope.todo = todo

