json.extract! @user, :id, :email

json.previews @user.previews do |preview|
  json.extract! preview, :id, :title, :author_id, :created_at, :updated_at
end

json.followers @user.followers do |follower|
  json.extract! follower, :id, :email
end
json.followed_users @user.followed_users do |followed|
  json.extract! followed, :id, :email
end

json.follows @user.in_follows

json.is_followed current_user.follows?(@user)
