require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end



it "shows ratings and count of them" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')
    click_button "Create Rating"
    expect(page).to have_content 'Has made 1 rating'
	
    visit new_rating_path
    select('Karhu', from:'rating[beer_id]')
    fill_in('rating[score]', with:'16')
    click_button "Create Rating"
    
    expect(page).to have_content 'Has made 2 ratings'
    expect(page).to have_content 'iso 3 15'
    expect(page).to have_content 'Karhu 16'
end



  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end
end
