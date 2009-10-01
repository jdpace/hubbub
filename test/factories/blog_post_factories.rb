Factory.define :blog_post do |post|
  post.user           {|u| u.association :author}
  post.title          'My Post'
  post.body           'Blah blah blah!'
end