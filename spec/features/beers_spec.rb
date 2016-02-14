require 'rails_helper'

include Helpers

describe "New beer" do

it "doesn't add a beer to the system if beer has a valid name" do
FactoryGirl.create :user
sign_in(username:"Pekka", password:"Foobar1")
visit new_beer_path
select('Weizen', from:'beer[style]')
expect{
      click_button('Create Beer')
    }.to change{User.count}.by(0)
end

it "adds a beer to the system if beer has a valid name" do
FactoryGirl.create :user
sign_in(username:"Pekka", password:"Foobar1")
visit new_beer_path
fill_in('beer[name]', with:'Olunen')
select('Weizen', from:'beer[style]')
expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
end

end
