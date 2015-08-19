selecta.controller('LikeHistoryController', ["$resource", "$scope", "UserLikes", "$stateParams", function($resource, $scope, UserLikes, $stateParams){

  SC.initialize({
    client_id: SOUNDCLOUD_ID
  });

  $scope.likes = [];

  var userId = $stateParams.userId;

  var likeHistory = UserLikes.find({user: userId});

  likeHistory.$promise.then(function(history){
    history.songs.forEach(function(like){
      SC.get("/tracks/" + like.soundcloud_id, function(track) {
        $scope.likes.push(track);
        $scope.$apply();
      });
    });
  });
}]);
