require 'rails_helper'

RSpec.describe Beer, type: :model do
  
  
  
   it "is created and saved" do
      beer = Beer.create name:"Kaljanen", style:"Weizen"
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  
    it "is not created without name" do
      beer = Beer.create style:"Weizen"
      expect(beer).not_to be_valid      
    end

    it "is not created without style" do
      beer = Beer.create name:"Kaljanen"
      expect(beer).not_to be_valid
    end
   
end
