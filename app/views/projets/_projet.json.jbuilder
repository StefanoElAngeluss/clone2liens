json.extract! projet, :id, :titre, :lien, :created_at, :updated_at
json.url projet_url(projet, format: :json)
