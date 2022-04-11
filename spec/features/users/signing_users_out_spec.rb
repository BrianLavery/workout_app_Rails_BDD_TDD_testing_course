require 'rails_helper'

RSpec.feature 'User sign up' do
  before do
    @john = User.create(email: 'john@example.com', password: 'password', first_name: 'John', last_name: 'Doe')
    login_as(@john)
  end

  scenario 'signing user out' do
    visit root_path
    click_link 'Logout'

    expect(page).to have_content("Signed out successfully")
    expect(page).not_to have_content("Sign out")
  end
end
