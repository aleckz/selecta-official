song = false;
playing = false;
currentSongId = '';


selecta.controller('TrackController', ["$resource", "$location", "$scope", "$window", 'FindSong', 'SongsUser', "$stateParams","$timeout", "$state", "$rootScope",function($resource, $location, $scope, $window, FindSong, SongsUser, $stateParams, $timeout, $state, $rootScope){
  $scope.songId = $stateParams.songId;
  currentSongId = $scope.songId;
  var nextsong = '';



  SC.initialize({
    client_id: SOUNDCLOUD_ID
  });

  SC.get("/tracks/" + $scope.songId, function(tracks){
    $scope.selected_song = tracks;
    $scope.$apply();
    console.log(tracks);
  });

  $scope.next = function() {
    test = FindSong.find({soundcloud_id: $scope.selected_song.id});
    console.log(test);
    test.$promise.then(function(song){
      nextsong = song.soundcloud_id;
      console.log(nextsong);
    }).then(function(){
      $state.go('track', {songId: nextsong });
      $rootScope.$on('$stateChangeSuccess',function(event, toState, toParams, fromState, fromParams){
        $scope.songId = toParams.songId;
        currentSongId = $scope.songId;
        $scope.play();
      });
    });
  };

  $scope.play = function(){
    console.log('play is working');
    $scope.songId = $stateParams.songId;
    currentSongId = $scope.songId;
    if (song) {
      var temp = song;
    }
    SC.stream("/tracks/" + $scope.songId,{onfinish: function(){ $scope.next();}}, function(sound){
      console.log($scope.songId);
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
            playing = true;
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

  $scope.currentSong = function(){
    $state.go('track', {songId: currentSongId });
  };



}]);
