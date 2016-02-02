
class User < ActiveRecord::Base
	include RatingAverage

	has_secure_password

	#validates :username, uniqueness: true
	#validates :username, length: { minimum: 3 }
	validates :username, uniqueness: true,
		  length: { minimum: 3, maximum: 15 }
	validates :password, length: {minimum: 4},
			     format: { with: /(.*[A-Z].*[0-9]|.*[0-9].*[A-Z])/, message: "Must contain at least one number and capital letter"}

	has_many :ratings   # käyttäjällä on monta ratingia
end
