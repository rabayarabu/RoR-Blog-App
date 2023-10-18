require 'rails_helper'

RSpec.describe "User Posts Page", type: :feature do
    before(:each) do
        @user = User.create(name: 'Lawrence McDaniel', photo: 'https://cdn.filestackcontent.com/e59vmdzRKGVwdjNKKLy0',
                            bio: 'Lawrence McDaniel is an American full stack developer.', posts_counter: 0)
  
        @post = Post.create(author: @user, title: 'Post 1', text: 'This is Post 1', comments_counter: 0, likes_counter: 0)
  
        @comment = Comment.create(post: @post, text: 'Post 1 comment')
 
    visit users_path(@user) 
  end

  it "displays a list of user's posts and recent comments" do
    expect(page).to have_selector("h1", text: "List of users")
    expect(page).to have_selector(".post_list")

    # Check if each post is displayed
    posts.each do |post|
      expect(page).to have_selector(".post", text: post.title) 
    end

    # Check if recent comments are displayed for the first post
    expect(page).to have_selector(".post_comment") 
    comments.each do |comment|
      expect(page).to have_selector(".comment", text: comment.text) 
    end
  end

  it "has a Back button" do
    expect(page).to have_selector(".button_holder")
    expect(page).to have_link("Back")
  end

  it "redirects to the previous page when clicking the Back button" do
    click_link "Back"
    expect(current_path).to eq(root_path) 
  end
end
