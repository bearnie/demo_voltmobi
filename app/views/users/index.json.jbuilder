json.array!(@users) do |user|
  json.extract! user, :id, :email, :name, :login, :date_of_birth, :disabled
  json.url user_url(user, format: :json)
end
