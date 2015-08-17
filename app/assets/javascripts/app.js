var selecta = angular.module('Selecta', ['ngResource','ui.router'])

.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

    $stateProvider

      .state('home',{
        url: '/',
        templateUrl: "home.html",
        controller: 'SongSearchController'
      })

      .state('track', {
        url: '/track/:songId',
        templateUrl: "track.html",
        controller: 'TrackController'
      });

      $urlRouterProvider.otherwise('/');

  }]);
