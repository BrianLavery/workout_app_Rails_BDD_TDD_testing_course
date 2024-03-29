require 'rails_helper'

RSpec.feature 'Creating Exercises' do
  before do
    @john = User.create(email: 'john@example.com', password: 'password', first_name: 'John', last_name: 'Doe')
    login_as(@john)

    visit root_path
    click_link "My Lounge"
    click_link "New Workout"

    expect(page).to have_link("Back")
  end

  scenario 'create exercise with valid inputs'  do
    fill_in 'Duration', with: 70
    fill_in 'Workout details', with: 'Weight lifting'
    fill_in 'Activity date', with: '2016-07-26'
    click_button('Create Exercise')

    expect(page).to have_content('Exercise has been created')

    exercise = Exercise.last

    expect(current_path).to eq(user_exercise_path(@john, exercise))
    expect(exercise.user_id).to eq(@john.id)
  end

  scenario 'create exercise with invalid inputs'  do


    fill_in 'Duration', with: '10 minutes'
    fill_in 'Workout details', with: ''
    fill_in 'Activity date', with: ''
    click_button('Create Exercise')

    expect(page).to have_content("Exercise has not been created")
    expect(page).to have_content("Duration in min is not a number")
    expect(page).to have_content("Workout details can't be blank")
    expect(page).to have_content("Activity date can't be blank")
  end
end
