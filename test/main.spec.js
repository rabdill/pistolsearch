const home = "http://localhost:4444/wd/hub";

describe('Pistol Search', function() {
  describe('main search page', function() {
    beforeAll(function() {
      browser.get('#/');
    });
    it('should load', function() {
      expect(browser.getTitle()).toEqual('Pistol Search');
    });

    it('should display the search criteria categories', function() {
      var categories = element.all(by.repeater('c in criteria.categories')).all(by.binding('c.display'));
      expect(categories.count()).toEqual(4);
      expect(categories.get(0).getText()).toEqual('Caliber');

      var expected = [
        'Caliber',
        'Frame',
        'Trigger mechanism',
        'Manufacturer'
      ];
      for(var i=0; i < expected.length; i++) {
        expect(categories.get(i).getText()).toEqual(expected[i]);
      }
    });

    it('should display the options within the categories', function() {
      var options = element.all(by.repeater('c in criteria.categories')).all(by.binding('m'));
      expect(options.get(0).getText()).toEqual('9mm');
    });
  });
});
