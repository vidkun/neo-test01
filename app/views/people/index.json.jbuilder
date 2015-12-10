json.array!(@people) do |person|
  json.extract! person, :id, :names
  json.url person_url(person, format: :json)
end
