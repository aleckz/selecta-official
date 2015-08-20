selecta.controller("SongSearchController", ['$scope', '$resource', function($scope, $resource) {

  SC.initialize({
    client_id: SOUNDCLOUD_ID
  });

  $scope.songs = [];

  $scope.doSearch = function(){
    if ($scope.searchTerm !== '') {
      return SC.get('https://api.soundcloud.com/tracks', { q: $scope.searchTerm }, function(tracks) {
        temporarySearchList = [];
        for (var i=0; i<tracks.length; i++) {
          if ((tracks[i].streamable) === true) {
            console.log("streamable true");
            temporarySearchList.push(tracks[i]);
          }
        }
        $scope.songs = temporarySearchList;
        $scope.$apply();
      });
    }
  };

  $scope.clearList = function(){
    $scope.songs = '';
  };
}]);
