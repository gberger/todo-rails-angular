angular.module("todoApp")

.factory "Todo", ($resource) ->
	$resource "//localhost:3000/todos/:id", id: "@id"

