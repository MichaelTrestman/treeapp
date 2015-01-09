json.array!(@publications) do |publication|
  json.extract! publication, :id, :title, :date
  json.url publication_url(publication, format: :json)
end
