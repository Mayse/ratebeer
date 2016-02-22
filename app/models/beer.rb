class Beer < ActiveRecord::Base
	include RatingAverage
	belongs_to :brewery
	belongs_to :style
	has_many :ratings, dependent: :destroy

	validates :name, presence: true
#	validates :style, presence: true

	def to_s
	"#{self.name}, #{self.brewery.name}"
	end
end
