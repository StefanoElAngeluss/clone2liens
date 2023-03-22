json.extract! liste, :id, :titre, :contenu, :completed, :user_id, :created_at, :updated_at
json.url liste_url(liste, format: :json)
