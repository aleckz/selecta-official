var selecta = angular.module('Selecta', ['ngResource','ui.router'])

.config([
'$stateProvider',
'$urlRouterProvider',
function($stateProvider, $urlRouterProvider) {

    $stateProvider

      .state('track', {
        url: '/track/:songId',
        templateUrl: "/track.html",
        controller: 'TrackController'
      });

  }]);
