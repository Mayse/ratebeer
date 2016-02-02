class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user   # rating kuuluu myös käyttäjään

	def to_s
	"#{self.beer.name} #{self.score}"
	end
end
