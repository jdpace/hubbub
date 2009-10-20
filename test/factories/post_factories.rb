Factory.define :post do |post|
  post.user           {|u| u.association :author}
  post.title          'My Post'
  post.body           'Blah blah blah!'
end

Factory.define :comment do |comment|
  comment.post          {|p| p.association :post }
  comment.author_name   'John Smith'
  comment.author_email  'jsmith@example.com'
  comment.body          'Lorem Ipsum Dolor'
end