require 'rails_helper'

RSpec.feature 'Searching for users' do
  before do
    @john = User.create(first_name: 'John', last_name: 'Doe', email: 'john@example.com', password: 'password')
    @sarah = User.create(first_name: 'Sarah', last_name: 'Jones', email: 'sarah@example.com', password: 'password')
    @sarah_doe = User.create(first_name: 'Sarah', last_name: 'Doe', email: 'sarahdoe@example.com', password: 'password')
  end

  scenario 'with existing name returns all users' do
    visit root_path

    fill_in 'search_name', with: 'Doe'
    click_button 'Search'

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@sarah_doe.full_name)
    expect(current_path).to eq '/dashboards/search'
  end
end
