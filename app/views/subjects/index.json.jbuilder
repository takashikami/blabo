json.array!(@subjects) do |subject|
  json.extract! subject, :id, :title, :pic, :quote
  json.url subject_url(subject, format: :json)
end
