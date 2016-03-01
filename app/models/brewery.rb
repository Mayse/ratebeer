class Brewery < ActiveRecord::Base
	include RatingAverage

	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	validates :name, presence: true
	validates :year, numericality: { greater_than_or_equal_to: 1024,
		                         less_than_or_equal_to: 2016,
					 only_integer: true }
	validate :year_between_1042_and_current

	scope :active, -> { where active:true }
	scope :retired, -> {where active:[nil,false]}

	def year_between_1042_and_current
		if self.year < 1042
			errors.add(:year)
		end
		if self.year > DateTime.now.year
			errors.add(:year)
		end
	end

	def self.top(n)
		sorted_by_rating_average = Brewery.all.sort_by{ |b| -(b.average_rating || 0) }
		sorted_by_rating_average[0, n]
	end

	def print_report
    	puts name
    	puts "established at year #{year}"
    	puts "number of beers #{beers.count}"
	end

	def restart
	self.year = 2016
	puts "changed year to #{year}"
	end

end
