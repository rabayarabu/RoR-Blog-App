class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  # Method to update the posts counter for a user
  after_create :increment_user_posts_counter
  after_destroy :decrement_user_posts_counter

  def increment_user_posts_counter
    author.increment!(:posts_count)
  end

  def decrement_user_posts_counter
    author.decrement!(:posts_count)
  end

  # Method to return the 5 most recent comments for a given post
  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end
end
