json.array!(@images) do |image|
  json.extract! image, :id, :filename, :cute_vote, :total_vote, :user_id
  json.url image_url(image, format: :json)
end
