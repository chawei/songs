Factory.sequence :youtube_url do |n|
  "http://www.youtube.com/watch?v=wI-GsAi#{n}"
end

Factory.define :song do |s|
  s.title 'Title'
  s.performer_name 'Performer'
end

Factory.define :video do |v|
  v.url { Factory.next(:youtube_url) }
end