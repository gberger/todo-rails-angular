angular.module("todoApp")

.value('API_ENDPOINT', '//localhost:3000/api')

.factory "Todo", (API_ENDPOINT, $resource) ->
	$resource "#{API_ENDPOINT}/todos/:id", id: "@id"

.factory "User", () ->
	isLogged: false,
	email: ''
	apiKey: '705b3860432d1a1147004ad22d711680'
