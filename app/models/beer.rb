class Beer < ActiveRecord::Base
	belongs_to :brewery
	has_many :ratings

	def average_rating

		arr = []
		Rating.all.each { |rating| arr << rating.score }
		a = arr.inject{ |sum, el| sum + el }.to_f / arr.size
		a.round
	end
	def to_s
	"#{self.name}, #{self.brewery.name}"
	end
end
