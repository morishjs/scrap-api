json.array!(@pages) do |page|
  json.id page.id
  json.title page.title
  json.content page.content
end
