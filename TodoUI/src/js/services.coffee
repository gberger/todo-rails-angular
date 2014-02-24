angular.module("todoApp")

.value('API_ENDPOINT', '//localhost:3000/api')

.factory "Todo", (API_ENDPOINT, $resource) ->
	$resource "#{API_ENDPOINT}/todos/:id", {id: "@id"}, {update: {method: 'PATCH'}}

.factory "User", (API_ENDPOINT, $http, $location, $cookieStore) ->
	User =
		isLoggedIn: false
		email: ''
		apiKey: ''
		apiKeyExpiresAt: null

	User.toJSON = ->
		isLoggedIn: @isLoggedIn
		email: @email
		apiKey: @apiKey
		apiKeyExpiresAt: @apiKeyExpiresAt

	User.fromJSON = (json) ->
		return unless json
		@isLoggedIn = json.isLoggedIn || false
		@email = json.email || ''
		@apiKey = json.apiKey || ''
		@apiKeyExpiresAt = json.apiKeyExpiresAt || null

	loginOrSignup = (loc, email, password) ->
		$http
			method: 'POST'
			url: API_ENDPOINT + loc
			data: email: email, password: password
		.success (data, status, headers, config) =>
				User.isLoggedIn = true
				User.email = data.email
				User.apiKey = data.api_key
				User.apiKeyExpiresAt = data.api_key_expires_at

	User.login = (email, password) ->
		loginOrSignup('/users/login', email, password)

	User.signup = (email, password) ->
		loginOrSignup('/users/signup', email, password)

	User.toStorage = ->
		$cookieStore.put('user', @toJSON())

	User.fromStorage = ->
		@fromJSON($cookieStore.get('user'))

	User.clear = ->
		@isLoggedIn = false
		@email = ''
		@apiKey = ''
		@apiKeyExpiresAt = null

	User.logout = ->
		@clear()
		$cookieStore.remove('user')
		$location.path('/login')

	User.changePassword = (oldPassword, newPassword) ->
		$http(method: 'PUT', url: "#{API_ENDPOINT}/users/reset_api_key", data: {email: @email, old_password: oldPassword, new_password: newPassword})

	User.resetApiKey = (password) ->
		$http(method: 'PUT', url: "#{API_ENDPOINT}/users/reset_api_key", data: {email: @email, password: password})
			.success (data, status, headers, config) =>
				@apiKey = data.api_key

	return User
