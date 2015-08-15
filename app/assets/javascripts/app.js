selecta = angular.module('Selecta', ['templates','ngRoute','controllers']);


  selecta.config(['$routeProvider', function($routeProvider) {

    $routeProvider

      .when('/', {
        templateUrl: "home.html",
        controller: 'SongSearchController'
      });
  }]);


controllers = angular.module('controllers', []);
controllers.controller("SongSearchController", function($scope) {
  console.log('hello');
});
