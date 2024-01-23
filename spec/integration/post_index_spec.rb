require 'rails_helper'

describe 'Post Index Page Features', type: :feature, js: true do
  before :each do
    @user1 = User.create(
      name: 'Harley Quinn',
      photo: 'https://www.istockphoto.com/photo/kitchen-in-new-luxury-home-with-quartz-table-gm1648248415-533867367?utm_campaign=srp_photos_top&utm_content=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fworkspace&utm_medium=affiliate&utm_source=unsplash&utm_term=workspace%3A%3A%3A',
      bio: 'user1 Pix',
      posts_counter: 5
    )

    post1 = Post.create(id: 44_444, title: 'Post 1', text: 'text 1', likes_counter: 0, comments_counter: 0,
                        author_id: @user1.id)
    post2 = Post.create(id: 5_555_555, title: 'Post 2', text: 'text 2', likes_counter: 0, comments_counter: 0,
                        author_id: @user1.id)
    Post.create(id: 6666, title: 'Post 3', text: 'text 3', likes_counter: 0, comments_counter: 0, author_id: @user1.id)
    Post.create(id: 7777, title: 'Post 4', text: 'text 4', likes_counter: 0, comments_counter: 0, author_id: @user1.id)

    @user1.comments.create(text: 'comment 1', post: post1)
    @user1.comments.create(text: 'comment 2', post: post1)
    @user1.comments.create(text: 'comment 3', post: post2)

    @user1.likes.create(post: post1)
  end

  it 'can see the user\'s profile picture' do
    visit user_posts_path(@user1.id)
    expect(page).to have_css('.comment-bio-card')
  end

  it 'can see the user\'s username' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Harley Quinn')
  end

  it 'can see the number of posts the user has written' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Post 1')
  end

  it 'can see the post\'s title' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Post 1')
  end

  it 'can see the post\'s body' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content(text)
  end

  # I can see the number of comments a post has.
  it 'can see how many comments a post has' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Comments: 2')
    expect(page).to have_content('Comments: 1')
  end

  it 'can see the first comments of a post' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('comment 1')
  end

  it 'can see how many likes a post has' do
    visit user_posts_path(@user1.id)
    expect(page).to have_content('Likes: 1')
    expect(page).to have_content('Likes: 0')
  end

  it 'can see a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(@user1.id)
    expect(page).to have_css('button')
  end

  it 'When I click on a post, it redirects me to that post\'s show page' do
    visit user_posts_path(@user1.id)
    click_link(href: user_post_path(@user1.id, 6666))
    expect(page).to have_current_path(user_post_path(@user1.id, 6666))
  end
end
