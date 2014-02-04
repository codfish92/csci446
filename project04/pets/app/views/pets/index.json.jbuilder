json.array!(@pets) do |pet|
  json.extract! pet, :id, :name, :age, :primaryType, :secondaryType, :image
  json.url pet_url(pet, format: :json)
end
