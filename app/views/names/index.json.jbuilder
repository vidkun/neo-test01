json.array!(@names) do |name|
  json.extract! name, :id, :given, :surname, :primary
  json.url name_url(name, format: :json)
end
