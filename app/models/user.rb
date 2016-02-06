class User < ActiveRecord::Base
    include RatingAverage

    has_many :ratings

    def count
	return ratings.count
    end
end
