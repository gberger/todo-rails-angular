angular.module('todoApp', ['ngRoute', 'ngResource']).
  config(['$routeProvider', function($routeProvider) {
    $routeProvider.when('/todos', {templateUrl: 'partials/todos.html', controller: 'TodosCtrl'});
    $routeProvider.when('/todos/:id', {templateUrl: 'partials/todo.html', controller: 'TodoCtrl'});
    $routeProvider.otherwise({redirectTo: '/todos'});
  }]);
