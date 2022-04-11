require 'rails_helper'

RSpec.feature 'Listing Exercises' do
  before do
    @john = User.create!(email: 'john@example.com', password: 'password', first_name: 'John', last_name: 'Doe')
    @sarah = User.create!(email: 'sarah@example.com', password: 'password', first_name: 'Sarah', last_name: 'Anderson')
    login_as(@john)

    @exercise1 = @john.exercises.create(duration_in_min: 20, workout: 'My body building activity', workout_date: Date.today)
    @exercise2 = @john.exercises.create(duration_in_min: 55, workout: 'Weight lifting', workout_date: 2.days.ago)
    @exercise3 = @john.exercises.create(duration_in_min: 35, workout: 'On treadmill', workout_date: 8.days.ago)

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario "shows user's workouts for last 7 days" do
    visit root_path
    click_link "My Lounge"

    expect(page).to have_content(@exercise1.duration_in_min)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)

    expect(page).to have_content(@exercise2.duration_in_min)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)

    expect(page).not_to have_content(@exercise3.duration_in_min)
    expect(page).not_to have_content(@exercise3.workout)
    expect(page).not_to have_content(@exercise3.workout_date)
  end

  scenario 'shows no exercises if none created' do
    @john.exercises.destroy_all

    visit root_path
    click_link 'My Lounge'

    expect(page).to have_content('No Workouts Yet')
  end

  scenario 'shows a list of users friends' do
    visit root_path

    click_link 'My Lounge'
    expect(page).to have_content('My Friends')
    expect(page).to have_link(@sarah.full_name)
    expect(page).to have_link('Unfollow')
  end
end
