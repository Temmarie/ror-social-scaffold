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
    click_button 'Add Friend'
    expect(page).to have_content('Stay in touch')
    expect(page).to have_content('Sarah')
  end
end
