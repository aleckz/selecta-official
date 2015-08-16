song = false;

selecta.controller('TrackController', ["$resource", "$location", "$scope", "$window", 'FindSong', 'SongsUser', "$stateParams","$timeout", "$state", "$rootScope",function($resource, $location, $scope, $window, FindSong, SongsUser, $stateParams, $timeout, $state, $rootScope){
  $scope.songId = $stateParams.songId;
  var playing = false;

  SC.initialize({
    client_id: SOUNDCLOUD_ID
  });

  SC.get("/tracks/" + $scope.songId, function(tracks){
    $scope.selected_song = tracks;
    $scope.$apply();
  });

  $scope.find = function() {
    test = FindSong.find({soundcloud_id: $scope.selected_song.id});
    console.log(test);
    test.$promise.then(function(song){
    console.log(song.song);
    });
    $state.go('track', {songId: 43891342});
    $rootScope.$on('$stateChangeSuccess',function(event, toState, toParams, fromState, fromParams){
      $scope.songId = toParams.songId;
      $scope.play();
    });
  };

  $scope.play = function(){
  if (song) {
    var temp = song;
  }
    SC.stream("/tracks/" + $scope.songId,{onfinish: function(){ $scope.next();}}, function(sound){
      song = sound;
      if (temp) {
        if (song.url != temp.url) {
          temp.stop();
          song.start();
          playing = true;
        } else {
          song = temp;
          if (!playing) {
            song.play();
          }
        }
      } else {
        if (!playing) {
          song.play();
          playing = true;
        }
      }
    });
  };

  $scope.stop = function(){
    song.pause();
    playing = false;
  };

  $scope.like = function(){
    SongsUser.create({soundcloud_id: $scope.songId});

  };

  $scope.next = function() {
    SC.get("/tracks/63848640", function(tracks){
      $scope.newsong = tracks;
      $scope.$apply();
    });
  };

}]);
