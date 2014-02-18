angular.module('todoApp').
  controller('TodosCtrl', function($scope, Todo){

  }).
  controller('TodoCtrl', function($scope, $routeParams, Todo){
    $scope.hello = 'world';
    $scope.id = $routeParams.id;
    var todo = Todo.get({id: $routeParams.id}, function(){
      $scope.todo = todo;
    })
  });
