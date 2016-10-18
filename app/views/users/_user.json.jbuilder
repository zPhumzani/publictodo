json.extract! user, :id, :first_nme, :last_name, :created_at, :updated_at
json.url user_url(user, format: :json)