
class User < ActiveRecord::Base
	include RatingAverage

	#validates :username, uniqueness: true
	#validates :username, length: { minimum: 3 }
	validates :username, uniqueness: true,
		length: { minimum: 3 }

	has_many :ratings   # käyttäjällä on monta ratingia
end
