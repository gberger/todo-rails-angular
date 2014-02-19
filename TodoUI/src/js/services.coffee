angular.module("todoApp")

.factory "Todo", ($resource) ->
	$resource "//localhost:3000/api/todos/:id", id: "@id"

.factory "User", () ->
	isLogged: false,
	email: ''
	apiKey: '705b3860432d1a1147004ad22d711680'
