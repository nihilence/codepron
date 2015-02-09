json.extract! @user, :id, :title

json.previews @user.previews do |preview|
  json.extract! list, :id, :title, :created_at, :updated_at
end
