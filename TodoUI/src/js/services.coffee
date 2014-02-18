angular.module("todoApp")

.factory "Todo", ($resource) ->
	$resource "//localhost:3000/api/v1/todos/:id", id: "@id"

