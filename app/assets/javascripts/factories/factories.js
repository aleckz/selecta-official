selecta.factory('FindSong', ['$resource', function($resource){
  return $resource('/songs/find.json', {}, {
  find: { method: 'GET' },
 });
}]);

selecta.factory('SongsUser', ['$resource',function($resource){
  return $resource('/songs.json', {},{
  query: { method: 'GET', isArray: true },
  create: { method: 'POST' }
  });
}]);

selecta.factory('UserLikes', ['$resource', function($resource){
  return $resource('/users/find.json', {}, {
    query: { method: 'GET', isArray: true }
  });
}]);
