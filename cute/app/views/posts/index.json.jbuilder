json.array!(@posts) do |post|
  json.extract! post, :id, :comment, :image_id, :user_id, :posted
  json.url post_url(post, format: :json)
end
