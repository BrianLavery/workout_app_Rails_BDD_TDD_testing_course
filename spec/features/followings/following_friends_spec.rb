require "rails_helper"

RSpec.feature "Following Friends" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @peter = User.create(first_name: "Peter", last_name: "Corn", email: "peter@example.com", password: "password")
    login_as(@john)
  end

  scenario 'if signed in' do
    visit root_path

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@peter.full_name)

    href_follow_john = "/friendships?friend_id=#{@john.id}"
    expect(page).not_to have_link("Follow", :href => href_follow_john)

    link_follow_peter = "a[href='/friendships?friend_id=#{@peter.id}']"
    find(link_follow_peter).click

    href_follow_peter = "/friendships?friend_id=#{@peter.id}"
    expect(page).not_to have_link("Follow", :href => href_follow_peter)
  end
end
