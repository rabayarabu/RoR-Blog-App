require 'rails_helper'

describe 'User Show Page Features', type: :feature, js: true do
  before :each do
    @user1 = User.create(
      name: 'Harley Quinn',
      photo: 'https://images.unsplash.com/photo-1696537768609-1cf03f53e893?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      bio: 'user1 Pix',
      posts_counter: 5
    )

    Post.create(id: 4111, title: 'Post 1', text: 'text 1', likes_counter: 0, comments_counter: 0, author_id: @user1.id)
    Post.create(id: 51_111, title: 'Post 2', text: 'text 2', likes_counter: 0, comments_counter: 0,
                author_id: @user1.id)
    Post.create(id: 611_111, title: 'Post 3', text: 'text 3', likes_counter: 0, comments_counter: 0,
                author_id: @user1.id)
  end
  # I can see the user's username.
  it 'can see the username' do
    visit user_path(@user1.id)
    expect(page).to have_text('Harley Quinn')
  end
  # # I can see the user's profile picture.
  it 'can see the user profile pic' do
    visit user_path(@user1.id)
    expect(page).to have_css('.photo')
  end
  # I can see the number of posts the user has written. 
  it 'can see the number of posts the user has written' do
    visit user_path(@user1.id)
    expect(page).to have_all_of_selectors('.posts')
  end

  # I can see the button that let me view all of user's posts.
  it 'display a button thay let me view all of user\'s posts' do
    visit user_path(@user1.id)
    click_link(href: user_post_path(@user1.id, 4111))
    expect(page).to have_current_path(user_post_path(@user1.id, 4111))
  end
  # I can see the user's bio.
  it 'can see the user\'s bio' do
    visit user_path(@user1.id)
    expect(page).to have_css('.user-card')
  end
  # I can see the user's first 3 posts. 
  it "should show the user's first 3 posts" do
    visit user_path(@user1.id)
    expect(page).to have_content(text)
  end
  # When I click a user's post, it redirects me to that post's show page.
  it 'redirect to the post\'s show page' do
    visit user_path(@user1.id)
    click_link(href: user_post_path(@user1.id, 4111))
    expect(page).to have_current_path(user_post_path(@user1.id, 4111))
  end
  # I can see a button that lets me view all of a user's posts.
  it 'redirects to the user\'s all posts page' do
    visit user_path(@user1.id)
    click_link(href: user_posts_path(@user1.id))
    expect(page).to have_current_path(user_posts_path(@user1.id))
  end
end
