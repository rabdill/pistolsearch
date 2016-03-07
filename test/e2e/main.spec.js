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
      // NOTE: This should really be re-written in a way that won't break as soon as criteria changes
      var options = element.all(by.repeater('c in criteria.categories')).all(by.binding('m'));
      expect(options.get(0).getText()).toEqual('9mm');
      expect(options.get(10).getText()).toEqual('carbon steel');
      expect(options.get(15).getText()).toEqual('hammer DAO');
      expect(options.get(17).getText()).toEqual('Glock');
    });

    describe('handgun list', function() {
      it('should display an unfiltered list of handguns', function() {
        // NOTE: This should really be re-written in a way that won't break as soon as criteria changes
        var guns = element.all(by.repeater('gun in guns'));
        expect(guns.count()).toEqual(55);
        expect(guns.first().element(by.tagName('a')).getInnerHtml()).toEqual('CZ 75 B (9mm)')
        expect(guns.get(1).element(by.tagName('a')).getInnerHtml()).not.toEqual('CZ 75 B (9mm)')
      });

      
    });



  });
});
