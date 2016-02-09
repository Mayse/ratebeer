require 'rails_helper'

RSpec.describe Beer, type: :model do

	describe "has a name and style set" do
		let(:beer){ Beer.create name:"Birra", style:"Porter" }
		it "is valid" do
			expect(beer).to be_valid
		end
		it "is saved" do
			beer.save	
			expect(Beer.count).to eq(1)
		end
	end

	describe "has only style set" do
		let(:beer){Beer.create style:"Porter"}
		it "is not valid" do
			expect(beer).not_to be_valid
		end
	end

	describe "has only name set" do
		let(:beer){Beer.create name:"Birra"}
		it "is not valid" do
			expect(beer).not_to be_valid
		end
	end
end
