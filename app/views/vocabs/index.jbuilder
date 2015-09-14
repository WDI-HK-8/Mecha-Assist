json.array! @vocabs do |vocab|
  json.id         vocab.id
  json.pinyin     vocab.pinyin
  json.english    vocab.english
  json.chinese    vocab.chinese
  json.created_at vocab.created_at
end
