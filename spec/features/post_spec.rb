require 'rails_helper'
require 'capybara/rails'

RSpec.describe 'Post Management:', type: :feature do
  before(:each) do
    @user = User.new(name: 'Sarah',
                     email: 'Sarah@email.com',
                     password: 'qwertyuiop',
                     password_confirmation: 'qwertyuiop')
    @user.save
  end

  scenario 'timeline posts and comments' do
    visit new_user_session_path
    fill_in 'user[email]', with: 'Sarah@email.com'
    fill_in 'user[password]', with: 'qwertyuiop'

    click_button 'Log in'
    fill_in 'post[content]', with: 'Cakes all the time'

    click_button 'Save'

    fill_in 'comment[content]', with: 'Chocolate cakes'

    click_button 'Comment'

    expect(page).to have_content('Chocolate')
  end
end
