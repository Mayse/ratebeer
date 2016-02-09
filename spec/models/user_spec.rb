require 'rails_helper'

RSpec.describe User, type: :model do


	describe "favorite beer" do
		let(:user){FactoryGirl.create(:user) }
		it "has method for determining the favorite_beer" do
			expect(user).to respond_to(:favorite_beer)
		end
		it "without ratings does not have a favorite beer" do
			expect(user.favorite_beer).to eq(nil)
		end

		it "is the only rated if only one rating" do
			beer = create_beer_with_rating(user, 10)
			expect(user.favorite_beer).to eq(beer)
		end

		it "is the one with highest rating if several rated" do
			create_beers_with_ratings(user, 10, 20, 15, 7, 9)
		  	best = create_beer_with_rating(user, 25)
			
      			expect(user.favorite_beer).to eq(best)

		end
	end

	describe "favorite style" do
		let(:user){FactoryGirl.create(:user)}
		it "has method for determining the favorite_style" do
			expect(user).to respond_to(:favorite_style)
		end
		it "without ratings does not have a favorite style" do
			expect(user.favorite_style).to eq(nil)
		end
		it "is the favorite style if only one rating" do
			beer = create_beer_with_rating(user, 10)
			expect(user.favorite_style).to eq(beer.style)
		end
		it "is the style which beer has the highest rating" do
	
			lager = FactoryGirl.create(:beer, style:"Lager")
			porter = FactoryGirl.create(:beer, style:"Porter")
			ipa = FactoryGirl.create(:beer, style:"IPA")
			rating1 = FactoryGirl.create(:rating, beer:lager, score:1)
			rating2 = FactoryGirl.create(:rating, beer:porter, score:3)
			rating3 = FactoryGirl.create(:rating, beer:ipa, score:2)
			user.ratings << rating1
			user.ratings << rating2
			user.ratings << rating3
			
			expect(user.favorite_style).to eq(porter.style)
		end
		it "is the style which beers have the highest average" do
			porter = FactoryGirl.create(:beer, style:"IPA")
			lager = FactoryGirl.create(:beer, style:"Lager")
			porter = FactoryGirl.create(:beer, style:"Porter")
			rating1 = FactoryGirl.create(:rating, beer:lager, score:15)
			rating2 = FactoryGirl.create(:rating, beer:porter, score:16)
			rating3 = FactoryGirl.create(:rating, beer:porter, score:1)
			user.ratings << rating1
			user.ratings << rating2
			user.ratings << rating3
			
			expect(user.favorite_style).to eq(lager.style)

		end
	end

	describe "with only username set" do
		let(:user){ User.create username:"pekka"}
			it "is not saved without a password" do
				user.save
				expect(user).not_to be_valid
				expect(User.count).to eq(0)
			end
	end

	 describe "with a proper password" do
		 let(:user){ FactoryGirl.create(:user) }

		 it "is saved" do
			 expect(user).to be_valid
			 expect(User.count).to eq(1)
		 end
		 it "and with two ratings, has the correct average rating" do
			 user.ratings << FactoryGirl.create(:rating)
			 user.ratings << FactoryGirl.create(:rating2)

			 expect(user.ratings.count).to eq(2)
			 expect(user.average_rating).to eq(15.0)
		 end
	 end

	 describe "with only alphabetical password" do
		 let(:user){ User.create username:"Pekka", password:"asdfghh", password_confirmation:"asdfghh" }
		 it "is not saved" do
			 expect(User.count).to eq(0)
		 end
		 it "is not valid" do
			 expect(user).not_to be_valid
		 end
	 end

	 describe "with short password" do
		 let(:user){ User.create username:"Pekka", password:"A3c", password_confirmation:"A3c" }
		 it "is not saved" do
			 expect(User.count).to eq(0)
		 end
		 it "is not valid" do
			 expect(user).not_to be_valid
		 end

	 end
end


def create_beer_with_rating(user, score)
	beer = FactoryGirl.create(:beer)
	FactoryGirl.create(:rating, score:score, beer:beer, user:user)
	beer
end

def create_beers_with_ratings(user, *scores)
	scores.each do |score|
		create_beer_with_rating(user, score)
	end
end
