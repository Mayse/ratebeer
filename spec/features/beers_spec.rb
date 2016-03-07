require 'rails_helper'

include Helpers

describe "Beer" do
	before :each do
		FactoryGirl.create :brewery
		FactoryGirl.create :user
		FactoryGirl.create :style
		sign_in(username:"Pekka", password:"Foobar1")
	end
	it "is added with a valid name" do
		visit beers_path
		expect(page).not_to have_content 'Kalja'
		click_link('New Beer')
		fill_in('beer[name]', with:"Kalja")
		click_button('Create Beer')
		expect(page).to have_content 'Kalja'
	end
end

describe "beerlist page" do

	before :all do
		self.use_transactional_fixtures = false
		WebMock.disable_net_connect!(allow_localhost:true)
	end

	before :each do
		DatabaseCleaner.strategy = :truncation
		DatabaseCleaner.start

		@brewery1 = FactoryGirl.create(:brewery, name: "Koff")
		@brewery2 = FactoryGirl.create(:brewery, name: "Schlenkerla")
		@brewery3 = FactoryGirl.create(:brewery, name: "Ayinger")
		@style1 = Style.create name: "Lager"
		@style2 = Style.create name: "Rauchbier"
		@style3 = Style.create name: "Weizen"
		@beer1 = FactoryGirl.create(:beer, name: "Nikolai", brewery: @brewery1, style: @style1)
		@beer2 = FactoryGirl.create(:beer, name: "Fastenbier", brewery: @brewery2, style: @style2)
		@beer3 = FactoryGirl.create(:beer, name: "Lechte Weisse", brewery: @brewery3, style: @style3)
	end

	after :each do
		DatabaseCleaner.clean
	end

	after :all do
		self.use_transactional_fixtures = true
	end

	it "shows a known beer", :js => true do
		visit beerlist_path
		find('table').find('tr:nth-child(2)')
		expect(page).to have_content "Nikolai"
	end

	it "is sorted in a name order", :js => true do
		visit beerlist_path
		expect(page.all('tr')[1].text).to have_content "Fastenbier"
		expect(page.all('tr')[2].text).to have_content "Lechte Weisse"
		expect(page.all('tr')[3].text).to have_content "Nikolai"
		@brewery4 = FactoryGirl.create(:brewery, name: "Bushy's Brewery Ltd")
		@style4 = Style.create name: "Craft"
		@beer4 = FactoryGirl.create(:beer, name: "Gibraltar", brewery:@brewery4, style:@style4)
		visit beerlist_path
		expect(page.all('tr')[2].text).to have_content "Gibraltar"
	end
	it "it is sorted by style when clicked", :js => true do
		visit beerlist_path
		page.all('a', :text => 'style').first.click
		expect(page.all('tr')[1].text).to have_content "Lager"
		expect(page.all('tr')[2].text).to have_content "Rauchbier"
		expect(page.all('tr')[3].text).to have_content "Weizen"
	end
	it "it is sorted by brewery when clicked", :js => true do
		visit beerlist_path
		page.all('a', :text => 'Brewery').first.click
		save_and_open_page
		expect(page.all('tr')[1].text).to have_content "Ayinger"
		expect(page.all('tr')[2].text).to have_content "Koff"
		expect(page.all('tr')[3].text).to have_content "Schlenkerla"
	end
end
