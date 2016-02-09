require 'rails_helper'

RSpec.describe User, type: :model do
	it "has the username set correctly" do
		user = User.new username:"Pekka"
		expect(user.username).to eq("Pekka")
	end


	it "is not saved without a password" do
		user = User.create username:"Pekka"
		expect(user).not_to be_valid
		expect(User.count).to eq(0)
	end

	
	it "is saved with a proper password" do
    		user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
		expect(user).to be_valid
		expect(User.count).to eq(1)
	end

	it "with a proper password and two ratings, has the correct average rating" do
		user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"
		rating = Rating.new score:10
		rating2 = Rating.new score:20
		user.ratings << rating
		user.ratings << rating2
		expect(user.ratings.count).to eq(2)
		expect(user.average_rating).to eq(15.0)
	end

	 describe "with a proper password" do
		 let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
		 it "is saved" do
			 expect(user).to be_valid
			 expect(User.count).to eq(1)
		 end
		 it "and with two ratings, has the correct average rating" do
			 rating = Rating.new score:10
			 rating2 = Rating.new score:20
			 user.ratings << rating
			 user.ratings << rating2
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
