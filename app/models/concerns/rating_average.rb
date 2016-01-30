module RatingAverage
	extend ActiveSupport::Concern
	def average_rating
		arr = []
		self.ratings.each { |rating| arr << rating.score }
		a = arr.inject{ |sum, el| sum + el }.to_f / arr.size
		a.round
	end
end
