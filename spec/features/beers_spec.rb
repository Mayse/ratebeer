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
