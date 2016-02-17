require 'rails_helper'

describe "Places" do
	it "if one is returned by the API, it is shown at the page" do
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
			[ Place.new( name:"Oljenkorsi", id: 1 ) ]
		)
		visit places_path
		fill_in('city', with: 'kumpula')
		click_button "Search"
		expect(page).to have_content "Oljenkorsi"
	end
	it "if many are returned by the API, all are shown at the page" do
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
			[ Place.new( name:"Oljenkorsi", id: 1 ), Place.new( name:"Olotila", id: 2 ) ]
		)
		visit places_path
		fill_in('city', with: 'kumpula')
		click_button "Search"
		expect(page).to have_content "Oljenkorsi"
		expect(page).to have_content "Olotila"
	end
	it "if no locations are returned by the API, no locations are shown" do
		allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
			Array.new
		)
		visit places_path
		fill_in('city', with: 'kumpula')
		click_button "Search"
		expect(page).to have_content "No locations in "
	end
end
