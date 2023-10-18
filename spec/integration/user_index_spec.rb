require 'rails_helper'

RSpec.describe "User Index Page", type: :feature do
  let!(:users) { create_list(:user, 3) } 

  before do
    visit users_path 
  end

  it "displays a list of users with their details" do
    expect(page).to have_selector(".user", count: 3) 

    users.each do |user|
      within(".user", text: user.name) do
        expect(page).to have_selector(".user_card_image img[src='#{user.photo}']")
        expect(page).to have_selector("h2 a[href='#{user_path(user)}']", text: user.name)
        expect(page).to have_content("Number of posts: #{user.posts_counter}")
      end
    end
  end
end
