class User < ActiveRecord::Base
    include RatingAverage

	has_secure_password

    validates :username, uniqueness: true
    validates :username, length: { minimum: 3 }
    validates :username, length: { maximum: 3 }
	
    has_many :ratings
    has_many :raters, -> { uniq }, through: :ratings, source: :user

    def count
	return ratings.count
    end
end
