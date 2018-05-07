json.extract! user, :id, :firstname, :lastname, :displayname, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
