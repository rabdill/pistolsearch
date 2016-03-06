const home = "http://localhost:4444/wd/hub";

describe('Pistol Search application', function() {
  it('should load the page', function() {
    browser.get('#/');
    expect(browser.getTitle()).toEqual('Pistol Search');
  });

  it('should display the criteria categories', function() {
    browser.get('#/');

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
});
