require 'rails_helper'

include Helpers

describe "User" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }

  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end
   
it "deletes rating from system by pressing delete" do
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
    click_link('Pekka')
    page.first(:link, "delete").click
    expect(page).to have_content 'Has made 1 rating'
    expect(page).to have_content 'Karhu 16'
end

it "shows users favourite style and brewery" do
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
    click_link('Pekka')
    expect(page).to have_content 'Favorite brewery: Koff'
    expect(page).to have_content 'Favorite style: Lager'
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

    click_link('Pekka')
    
    expect(page).to have_content 'Has made 2 ratings'
    expect(page).to have_content 'iso 3 15'
    expect(page).to have_content 'Karhu 16'
end





    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  
  
  
  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  





  end

    

end

