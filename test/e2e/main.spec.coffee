describe 'Pistol Search', ->
	describe 'main search page', ->
		###
		NOTE: There is a "beforeAll" hook for this section,
		but it's at the bottom of the clause because it includes
		a mock of the GUNS factory, which is gigantic.
		###

		it 'should load', ->
			expect(browser.getTitle()).toEqual 'Pistol Search'

		it 'should display the search criteria categories', ->
			categories = (element.all By.repeater 'c in criteria.categories').all By.binding 'c.display'
			(expect categories.count()).toEqual 4
			(expect (categories.get 0).getText()).toEqual 'Caliber'

			expected =
			for item, i in ['Caliber', 'Frame', 'Trigger mechanism', 'Manufacturer']
				(expect (categories.get i).getText()).toEqual item;

		it 'should display the options within the categories', ->
			# NOTE: This should really be re-written in a way that won't break as soon as criteria changes
			options = (element.all By.repeater 'c in criteria.categories').all By.binding 'm'
			(expect (options.get 0).getText()).toEqual '9mm'
			(expect (options.get 10).getText()).toEqual 'carbon steel'
			(expect (options.get 15).getText()).toEqual 'hammer DAO'
			(expect (options.get 17).getText()).toEqual 'Glock'

		describe 'handgun list', ->
			it 'should display an unfiltered list of handguns', ->
				#NOTE: This should really be re-written in a way that won't break as soon as criteria changes
				guns = element.all By.repeater 'gun in guns'
				(expect guns.count()).toEqual 55
				expect(guns.get(0).element(By.css('.md-headline')).getInnerHtml()).toEqual 'CZ 75 B'
				expect(guns.get(6).element(By.css('.md-headline')).getInnerHtml()).not.toEqual 'CZ 75 B'

		describe 'filtering', ->
			it 'should remove handguns that do not meet a selected filter', ->
				options = element.all By.repeater 'm in c.members'
				(expect options.count()).toEqual 20

	beforeAll ->
		browser.get('#/');
