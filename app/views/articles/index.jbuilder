json.array! @articles do |article|
  json.id article.id
  json.content article.content
  json.created_at post.created_at
end
