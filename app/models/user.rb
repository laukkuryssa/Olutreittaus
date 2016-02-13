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
    has_many :memberships
    has_many :beer_clubs, through: :memberships

    def count
	return ratings.count
    end

    def favorite_beer
       return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
    end

    def rated_styles
        return nil if ratings.empty?
    ratings.select{ |a| a.beer.style }
    end

    def favorite_style
	return nil if ratings.empty?  
    rated_styles.order(beer.average :desc).limit(1).first.beer.style
    end
end
