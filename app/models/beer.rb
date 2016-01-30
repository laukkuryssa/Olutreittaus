class Beer < ActiveRecord::Base
	include RatingAverage
	
	belongs_to :brewery
	has_many :ratings, dependent: :destroy
	
	def summa
		return ratings.count
	end

	def to_s
	  return self.name + ", " + self.brewery.name
	end
end

