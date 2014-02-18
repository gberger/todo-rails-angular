angular.module('todoApp').
  factory('Todo', function($resource) {
    return $resource('//localhost:3000/todos/:id', {id: '@id'})
  });
