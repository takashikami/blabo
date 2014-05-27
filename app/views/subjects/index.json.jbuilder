json.array!(@subjects) do |subject|
  json.extract! subject, :id, :title, :quote
  json.img img_subject_path(subject, format: :json)
  json.comments subject.comments, :comment
  json.url subject_url(subject, format: :json)
end
