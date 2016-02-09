
class User < ActiveRecord::Base
	include RatingAverage

	has_many :memberships, dependent: :destroy
	has_many :ratings, dependent: :destroy   # käyttäjällä on monta ratingia
	has_secure_password

	validates :username, uniqueness: true,
		  length: { minimum: 3, maximum: 15 }
	validates :password, length: {minimum: 4},
			     format: { with: /(.*[A-Z].*[0-9]|.*[0-9].*[A-Z])/, message: "Must contain at least one number and capital letter"}


	def favorite_beer
		return nil if ratings.empty?   # palautetaan nil jos reittauksia ei ole
		ratings.order(score: :desc).limit(1).first.beer
	end

end
