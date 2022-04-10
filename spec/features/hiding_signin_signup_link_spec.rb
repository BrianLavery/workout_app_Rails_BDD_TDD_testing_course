require 'rails_helper'

RSpec.feature 'Hiding sign in and sign up links' do
  before do
    @john = User.create(email: 'john@example.com', password: 'password')
  end

  scenario 'view links prior to signin' do
    visit root_path

    expect(page).to have_link("Sign in")
    expect(page).to have_link("Sign up")
    expect(page).not_to have_link("Logout")
  end

  scenario 'expect links to disappear after successful sign in' do
    login_as(@john)
    visit root_path

    expect(page).not_to have_link("Sign in")
    expect(page).not_to have_link("Sign up")
    expect(page).to have_link("Logout")
  end
end
