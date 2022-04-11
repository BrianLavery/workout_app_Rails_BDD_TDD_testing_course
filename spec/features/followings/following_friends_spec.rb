require "rails_helper"

RSpec.feature "Following Friends" do
  before do
    @john = User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password")
    @peter = User.create(first_name: "Peter", last_name: "Corn", email: "peter@example.com", password: "password")
    login_as(@john)
  end

  scenario 'if signed in and not yet followed peter' do
    visit root_path

    expect(page).to have_content(@john.full_name)
    expect(page).to have_content(@peter.full_name)

    # href_follow_peter = "/friendships?friend_id=#{@peter.id}"
    # expect(page).to have_link("Follow", :href => href_follow_peter)

    # Page should have a form to follow peter - (form as we use the button helper)
    expect(page).to have_xpath("//form[@action='/friendships?friend_id=#{@peter.id}']")

    # href_follow_john = "/friendships?friend_id=#{@john.id}"
    # expect(page).not_to have_button("Follow", :href => href_follow_john)
    expect(page).not_to have_xpath("//form[@action='/friendships?friend_id=#{@john.id}']")
  end

  scenario 'if signed in and then followed peter' do
    visit root_path

    follow_peter_form = page.find(:xpath, "//form[@action='/friendships?friend_id=#{@peter.id}']")
    # follow_peter_form.click_on(class: 'btn')
    follow_peter_form.find('.btn').click

    expect(page).not_to have_xpath("//form[@action='/friendships?friend_id=#{@peter.id}']")

    # link_follow_peter = "a[href='/friendships?friend_id=#{@peter.id}']"
    # find(link_follow_peter).click

    # href_follow_peter = "/friendships?friend_id=#{@peter.id}"
    # expect(page).not_to have_link("Follow", :href => href_follow_peter)
  end
end


# Used:
# https://stackoverflow.com/questions/43396872/capybara-click-element-by-class-name
# https://gist.github.com/tomas-stefano/6652111
