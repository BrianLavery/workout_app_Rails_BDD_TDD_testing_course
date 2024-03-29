require 'rails_helper'

RSpec.feature 'Editing Exercise' do
  before do
    @owner = User.create!(email: 'owner@example.com', password: 'password', first_name: 'Owner', last_name: 'Doe')
    @owner_exercise = @owner.exercises.create!(duration_in_min: 48, workout: 'Bodybuilding', workout_date: Date.today)
    login_as(@owner)
  end

  scenario 'suceeds with valid data' do
    visit root_path

    click_link "My Lounge"

    path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}/edit"
    link = "a[href=\'#{path}'\]"
    find(link).click

    fill_in 'Duration', with: 45
    click_button 'Update Exercise'

    expect(page).to have_content('Exercise has been updated')
    expect(page).to have_content(45)
    expect(page).not_to have_content(48)
  end
end
