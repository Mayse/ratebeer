require 'rails_helper'

include Helpers

describe "Rating" do
	let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
	let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
	let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
	let!(:user) { FactoryGirl.create :user }

	before :each do
		sign_in(username:"Pekka", password:"Foobar1")
	end

	it "when given, is registered to the beer and user who is signed in" do
		visit new_rating_path
		select('iso 3', from:'rating[beer_id]')
		fill_in('rating[score]', with:'15')
		expect{
			click_button "Create Rating"
		}.to change{Rating.count}.from(0).to(1)
		
		expect(user.ratings.count).to eq(1)
		expect(beer1.ratings.count).to eq(1)
		expect(beer1.average_rating).to eq(15.0)
	end
	it "ratings page shows the amount of ratings" do
		place_ratings
		visit ratings_path

		expect(page).to have_content "Number of ratings: #{Rating.count}"
	end
	it "lists the rated beers and scores" do
		place_ratings
		visit ratings_path

		user.ratings.each do |r|
		expect(page).to have_content "#{r.beer.name} #{r.score}"
		end

	end
	it "user page does not show other users ratings" do
		place_ratings
		user2 = FactoryGirl.create(:user, username:'Paavo')
		user2.ratings << FactoryGirl.create(:rating, beer:beer1, score:25)
		visit user_path(user)
		save_and_open_page
	
		expect(page).not_to have_content "#{user2.ratings.first.beer.name} #{user2.ratings.first.score}"
	end
end
def place_ratings
		user.ratings << FactoryGirl.create(:rating, beer:beer1)
	  	user.ratings << FactoryGirl.create(:rating2, beer:beer1)
	  	user.ratings << FactoryGirl.create(:rating2, beer:beer2)
end
