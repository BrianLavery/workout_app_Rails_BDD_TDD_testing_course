require 'rails_helper'

RSpec.feature 'User sign up' do
  first_name = 'John'
  last_name = 'Doe'

  scenario 'with valid credentals' do
    visit root_path
    click_link 'Sign up'
    fill_in 'First name', with: first_name
    fill_in 'Last name', with: last_name
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content('You have signed up successfully')

    visit root_path

    expect(page).to have_content("#{first_name} #{last_name}")
  end

  # scenario 'with blank credentals' do
  #   visit root_path
  #   click_link 'Sign up'
  #   fill_in 'Email', with: ''
  #   fill_in 'Password', with: ''
  #   fill_in 'Password confirmation', with: ''
  #   click_button 'Sign up'

  #   # expect(page).to have_content('')
  # end
end
