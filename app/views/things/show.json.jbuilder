if @thing.present?
    json.extract! @thing, :id, :body, :file_url, :created_at, :updated_at
    json.url thing_url(@thing, format: :json)
end
