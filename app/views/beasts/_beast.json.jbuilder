json.extract! beast, :id, :firstname, :lastname, :pseudo, :degree, :rating, :bio, :created_at, :updated_at
json.url beast_url(beast, format: :json)
