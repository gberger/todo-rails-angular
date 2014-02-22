angular.module("todoApp", ["ngRoute", "ngResource", "ngAnimate", "angular-growl", "ui.bootstrap", "xeditable"])

.config ($routeProvider, $httpProvider, growlProvider) ->
	$httpProvider.interceptors.push 'TodoAPIInterceptor'

	$routeProvider.when "/login",
		templateUrl: "partials/login.html"
		controller: "LoginCtrl"

	$routeProvider.when '/home',
		redirectTo: '/todos'

	$routeProvider.when "/todos",
		templateUrl: "partials/todos.html"
		controller: "TodosCtrl"

	$routeProvider.otherwise redirectTo: "/todos"

	$httpProvider.responseInterceptors.push(growlProvider.serverMessagesInterceptor);
	growlProvider.globalTimeToLive(5000)

.factory 'TodoAPIInterceptor', ($q, $rootScope, $location, User, growl) ->
		request: (config) ->
			config.headers['ApiKey'] = User.apiKey if User.isLoggedIn
			return config

		responseError: (rejection) ->
			switch rejection.status
				when 401
					growl.addWarnMessage('Please login.')
					$location.path '/login'

			$q.reject rejection

.run (editableThemes, editableOptions) ->
	editableOptions.theme = 'bs3'
	editableThemes.bs3.inputClass = 'input-block'
	editableThemes.bs3.formTpl = '<form class="editable-wrap" role="form"></form>'
