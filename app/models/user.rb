class User < ActiveRecord::Base
    include RatingAverage

    has_many :ratings


    def summa
	return ratings.count
    end
end
