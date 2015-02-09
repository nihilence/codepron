class Comment < ActiveRecord::Base
  validates :body, :author_id, :preview_id, presence: true
  belongs_to :preview
  belongs_to :author, foreign_key: "user_id", class_name: "User"
end
