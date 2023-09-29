class Like < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :user, class_name: 'User'
  # Method to update the likes counter for a post
  after_create :increment_post_likes_counter
  after_destroy :decrement_post_likes_counter

  def increment_post_likes_counter
    post.increment!(:likes_count)
  end

  def decrement_post_likes_counter
    post.decrement!(:likes_count)
  end
end
