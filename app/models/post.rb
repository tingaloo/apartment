class Post < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  validates :title, presence: true, length: {minimum: 3}
  # validates :content, presence: true
end
