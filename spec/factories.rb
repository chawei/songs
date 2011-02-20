Factory.sequence :youtube_url do |n|
  "http://www.youtube.com/watch?v=wI-GsAi#{n}"
end

Factory.sequence :title do |n|
  "Title #{n}"
end

Factory.define :artist do |s|
  s.name 'Awesome Artist'
end

Factory.define :song do |s|
  s.title { Factory.next(:title) }
  s.performer_name 'Performer'
end

Factory.define :video do |v|
  v.url { Factory.next(:youtube_url) }
end