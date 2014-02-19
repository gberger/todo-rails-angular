angular.module("todoApp")

.value('API_ENDPOINT', '//localhost:3000/api')

.factory "Todo", (API_ENDPOINT, $resource) ->
	$resource "#{API_ENDPOINT}/todos/:id", id: "@id"

.factory "User", () ->
	isLoggedIn: true,
	email: ''
	apiKey: ''
