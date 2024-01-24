class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'
  # Method to update the comments counter for a post
  after_create :increment_post_comments_counter
  after_destroy :decrement_post_comments_counter

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end

  def decrement_post_comments_counter
    post.decrement!(:comments_counter)
  end
end
