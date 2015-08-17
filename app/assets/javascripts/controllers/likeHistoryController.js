selecta.controller('LikeHistoryController', ["$resource", "$scope", "UserLikes", "$stateParams", function($resource, $scope, UserLikes, $stateParams){

  var userId = $stateParams.userId;
  console.log(userId)
  likes = UserLikes.find({user: userId});
  console.log(likes)


}]);
