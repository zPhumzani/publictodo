json.extract! task, :id, :user_id, :content, :slug, :private, :created_at, :updated_at
json.url task_url(task, format: :json)