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
  });

  $scope.next = function() {
    var next = true;
    test = FindSong.find({soundcloud_id: $scope.selected_song.id});
    test.$promise.then(function(song){
      nextsong = song.soundcloud_id;
    }).then(function(){
      $state.go('track', {songId: nextsong });
      $rootScope.$on('$stateChangeSuccess',function(event, toState, toParams, fromState, fromParams){
        if (next) {
          $scope.songId = toParams.songId;
          currentSongId = $scope.songId;
          $scope.play();
          next = false;
        }
      });
    });
  };

  $scope.play = function(){
    $scope.songId = $stateParams.songId;
    currentSongId = $scope.songId;
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
