class User < ActiveRecord::Base
    include RatingAverage

	has_secure_password


	PASSWORD_FORMAT = /\A
 	 (?=.{4,})          
 	 (?=.*\d)           
 	 (?=.*[A-Z])
	/x

    validates :username, uniqueness: true
    validates :username, length: { minimum: 3 }
    validates :username, length: { maximum: 15 }
    validates :password, format: {with: PASSWORD_FORMAT}    
	
    has_many :ratings, dependent: :destroy
    has_many :raters, -> { uniq }, through: :ratings, source: :user

    def count
	return ratings.count
    end
end
