json.array! @vocabs do |vocab|
  json.id         vocab.id
  json.content    vocab.content
  json.created_at vocab.created_at
  json.image      user.image
end
