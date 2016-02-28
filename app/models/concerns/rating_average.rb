module RatingAverage
	extend ActiveSupport::Concern
	def average_rating
		return 0 if ratings.empty?
		arr = []
		self.ratings.each { |rating| arr << rating.score }
		a = arr.inject{ |sum, el| sum + el }.to_f / arr.size
		#a.round
		return a
	end
end
