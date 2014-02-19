angular.module("todoApp")

.value('API_ENDPOINT', '//localhost:3000/api')

.factory "Todo", (API_ENDPOINT, $resource) ->
	$resource "#{API_ENDPOINT}/todos/:id", {id: "@id"}, {update: {method: 'PATCH'}}

.factory "User", () ->
	isLoggedIn: true,
	email: ''
	apiKey: '02a8a6fb424000639688968923b3ed4f'
