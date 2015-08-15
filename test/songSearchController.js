describe('SongSearchController', function() {
  beforeEach(module('Selecta'));

  var ctrl;

  beforeEach(inject(function($controller) {
    ctrl = $controller('SongSearchController');

    it('initialises with an empty search result and term', function() {
      expect(ctrl.searchResult).toBeUndefined();
      expect(ctrl.searchTerm).toBeUndefined();
    });

  }));
});
