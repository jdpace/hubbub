Factory.sequence(:email) {|n| "user#{n}@example.com"}

Factory.define :user do |u|
  u.name                  'John Smith'
  u.email                 { Factory.next :email }
  u.password              'password'
  u.password_confirmation 'password'
end

Factory.define :admin, :parent => :user do |a|
  a.name                  'Administrator'
  a.admin                 true
end

Factory.define :author, :parent => :user do |a|
  a.name                  'Author'
  a.author                true
end