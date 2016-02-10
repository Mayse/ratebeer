require 'rails_helper'

include Helpers

describe "Beer" do
	before :each do
		FactoryGirl.create :brewery
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
