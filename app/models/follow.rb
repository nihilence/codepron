class Follow < ActiveRecord::Base
  belongs_to :follower
  belongs_to :followed
end
