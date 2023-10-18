require 'rails_helper'

RSpec.describe "Post Show Page", type: :feature do
  let(:user) { create(:user) } 
  let(:post) { create(:post, author: user) } 

  before do
    visit post_path(post) 
  end

  it "displays the 'Add New Post' form" do
    expect(page).to have_selector("h3", text: "Add New Post")

    within('form') do
      expect(page).to have_field('post[title]')
      expect(page).to have_field('post[text]')
      expect(page).to have_button('Create Post')
    end
  end

  it "allows creating a new post" do
    fill_in "post[title]", with: "New Post Title"
    fill_in "post[text]", with: "This is a new post."
    click_button "Create Post"
    
    expect(page).to have_content("New Post Title")
    expect(page).to have_content("This is a new post.")
  end
end
