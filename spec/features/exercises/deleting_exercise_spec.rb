require 'rails_helper'

RSpec.feature 'Deleting Exercise' do
  before do
    @owner = User.create!(email: 'owner@example.com', password: 'password', first_name: 'Owner', last_name: 'Doe')
    @owner_exercise = @owner.exercises.create!(duration_in_min: 48, workout: 'Bodybuilding', workout_date: Date.today)
    login_as(@owner)
  end

  scenario do
    visit root_path
    click_link 'My Lounge'

    path = "/users/#{@owner.id}/exercises/#{@owner_exercise.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Destroy']"

    find(:xpath, link).click

    expect(page).to have_content('Exercise has been deleted')
  end
end
