angular.module("todoApp")

.factory "Todo", ($resource) ->
	$resource "//localhost:3000/api/todos/:id", id: "@id"

