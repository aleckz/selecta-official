var selecta = angular.module('Selecta', ['ngResource','templates','ngRoute']);


  selecta.config(['$routeProvider', function($routeProvider) {

    $routeProvider

      .when('/', {
        templateUrl: "home.html",
        controller: 'SongSearchController'
      });
  }]);

selecta.controller("SongSearchController", ['$scope', '$resource', function($scope, $resource) {

  SC.initialize({
    client_id: SOUNDCLOUD_ID
  });

  $scope.songs = [];

  $scope.doSearch = function(){
    if ($scope.searchTerm !== '') {
      return SC.get('http://api.soundcloud.com/tracks', { q: $scope.searchTerm }, function(tracks) {
        $scope.songs = tracks;
        $scope.$apply();
      });
    }
  };

  $scope.clearList = function(){
    $scope.songs = '';
  };
}]);
