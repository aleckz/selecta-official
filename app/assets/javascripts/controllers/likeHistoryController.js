selecta.controller('LikeHistoryController', ["$resource", "$scope", "UserLikes", "$stateParams", function($resource, $scope, UserLikes, $stateParams){
  
  SC.initialize({
    client_id: SOUNDCLOUD_ID
  });

  $scope.likes = [];

  var userId = $stateParams.userId;

  var likeHistory = UserLikes.find({user: userId});
  
  // likeHistory.$promise.then(function(history){
  //   history.songs.forEach(function(like){
  //     likes_id_list.push(like.soundcloud_id)
  //   });
  // });

  likeHistory.$promise.then(function(history){
    history.songs.forEach(function(like){
      SC.get("/tracks/" + like.soundcloud_id, function(track) {
        $scope.likes.push(track);
        $scope.$apply();
      });
    });
  });

  // likes_id_list.forEach(function(id){
  //   SC.get("/tracks/" + id, function(tracks) {
  //     $scope.likes.push(tracks);
  //     // $scope.$apply();
  //   });
  //   console.log($scope.likes)
  // });
}]);
