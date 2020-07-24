require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Friendships Management:', type: :feature do
  before(:each) do 
    @user = User.new(name: 'Sarah',
                    email: 'Sarah@email.com',
                    password: 'qwertyuiop',
                    password_confirmation: 'qwertyuiop')
    @user.save

    @friend = User.new(name: 'WhyteW',
                      email: 'gideon@email.com',
                      password: 'gideon',
                      password_confirmation: 'gideon')
    @friend.save

    visit new_user_session_path

    fill_in 'user[email]', with: 'Sarah@email.com'
    fill_in 'user[password]', with: 'qwertyuiop'

    click_button 'Log in'

    expect(page).to have_content('Stay in touch')
    visit users_path
    expect(page).to have_content('Sarah')
  end

  scenario 'add friend' do
    click_button 'Add friend'
    expect(page).to have_content('Friendship request sent')
    expect(page).to have_content('Pending Invitation')
  end

  scenario 'accept request' do
    click_on 'Add friend'
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user[email]', with: 'gideon@email.com'
    fill_in 'user[password]', with: 'gideon'
    click_button 'Log in'
    visit users_path
    click_on 'Accept'
    expect(page).to have_content('friend accepted')
    expect(page).to have_content('Added')
  end

  scenario 'reject request' do
    click_on 'Add friend'
    click_on 'Sign out'
    visit new_user_session_path
    fill_in 'user[email]', with: 'gideon@email.com'
    fill_in 'user[password]', with: 'gideon'
    click_button 'Log in'
    visit users_path
    click_on 'Decline'
    expect(page).to have_content('Add friend')
  end
end