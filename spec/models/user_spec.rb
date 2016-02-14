require 'rails_helper'

RSpec.describe User, type: :model do

  # ..

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating(user, 10)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(user, 10, 20, 15, 7, 9)
      best = create_beer_with_rating(user, 25)

      expect(user.favorite_beer).to eq(best)
    end
    
    

end

describe "favorite style" do
    let(:user){FactoryGirl.create(:user) }
   
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

        it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end
it "is the style of the only rated beer if only one rating" do
      beer = create_beer_with_rating_and_style(user, "Lager", 10)

      expect(user.favorite_style).to eq(beer.style)
    end

it "is the style of beer which has highest average rating from user if several rated" do
      create_beers_with_ratings_and_styles(user, "Lager", 9, 4, 2)
	create_beers_with_ratings_and_styles(user, "Moi", 1, 4, 2)
	best = create_beer_with_rating_and_style(user, "Paras", 25)
      expect(user.favorite_style).to eq(best.style)
    end

    end
    
describe "favorite brewery" do
    let(:user){FactoryGirl.create(:user) }
   
    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

        it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

it "is the brewery of the only rated beer if only one rating" do
      panimo1 = Brewery.create name:"Kauhula", year:2000
      beer = create_beer_with_rating_and_brewery(user, panimo1, 10)

      expect(user.favorite_brewery).to eq(beer.brewery.name)
    end

it "is the brewery of beer which has highest average rating from user if several rated" do
	panimo1 = Brewery.create name:"Panimola", year:2000
	panimo2 = Brewery.create name:"Kumipula", year:1987
	panimo3 = Brewery.create name:"ParasPanimo", year:1999
      create_beers_with_ratings_and_breweries(user, panimo1, 9, 4, 2)
	create_beers_with_ratings_and_breweries(user, panimo2, 1, 4, 2)
	best = create_beer_with_rating_and_brewery(user, panimo3, 25)
      expect(user.favorite_brewery).to eq(best.brewery.name)
    end
    end

end
# describe User

def create_beers_with_ratings(user, *scores)
  scores.each do |score|
    create_beer_with_rating user, score
  end
end

def create_beers_with_ratings_and_styles(user, style, *scores)
  scores.each do |score|
    create_beer_with_rating_and_style user, style, score
  end
end

def create_beers_with_ratings_and_breweries(user, brewery, *scores)
  scores.each do |score|
    create_beer_with_rating_and_brewery user, brewery, score
  end
end


def create_beer_with_rating(user, score)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end

def create_beer_with_rating_and_style(user, style, score)
  beer = FactoryGirl.create(:beer, style:style)
  FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end

def create_beer_with_rating_and_brewery(user, brewery, score)
  beer = FactoryGirl.create(:beer, brewery:brewery)
  FactoryGirl.create(:rating, score:score,  beer:beer, user:user)
  beer
end
