require 'rails_helper'

describe 'User Index Page Features', type: :feature, js: true do
  before :each do
    @user1 = User.create(
      name: 'Harley Quinn',
      photo: 'https://images.unsplash.com/photo-1696537768609-1cf03f53e893?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1374&q=80',
      bio: 'user1 Pix',
      posts_counter: 5
    )
  end
  # I can see the username of all other users.
  it 'can see the username of all other users' do
    visit users_path
    expect(page).to have_all_of_selectors('.user-info')
  end
  # I can see the profile picture for each user.
  it 'can see the profile pic of each users' do
    visit users_path
    expect(page).to have_all_of_selectors('.photo')
  end
  # I can see the number of posts each user has written.
  it 'can see the number of posts each user has written' do
    visit users_path
    expect(page).to have_all_of_selectors('.posts')
  end
  # When I click on a user, I am redirected to that user's show page. 
  it 'redirect to the user\'s show page' do
    visit users_path
    click_link(href: user_path(@user1.id))
    expect(page).to have_current_path(user_path(@user1.id))
  end
end
