angular.module("todoApp")

.value('API_ENDPOINT', '//localhost:3000/api')

.factory "Todo", (API_ENDPOINT, $resource) ->
	$resource "#{API_ENDPOINT}/todos/:id", {id: "@id"}, {update: {method: 'PATCH'}}

.factory "User", () ->
	isLoggedIn: false,
	email: ''
	apiKey: ''
