class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def print_report
    	puts name
    	puts "established at year #{year}"
    	puts "number of beers #{beers.count}"
	end

	def restart
	self.year = 2016
	puts "changed year to #{year}"
	end

	def average_rating
        arr = []
        self.ratings.each { |rating| arr << rating.score }
        a = arr.inject{ |sum, el| sum + el }.to_f / arr.size
        a.round
	end
end
