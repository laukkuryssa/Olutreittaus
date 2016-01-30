module RatingAverage
  extend ActiveSupport::Concern

	def average_rating
		t = ratings.map(&:score)
		a = t.sum
		return a.to_f / ratings.count.to_f
	end
  
end
