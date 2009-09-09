Factory.sequence(:email) {|n| "user#{n}@example.com"}

Factory.define :user do |u|
  u.name                  'John Smith'
  u.email                 { Factory.next :email }
  u.password              'password'
  u.password_confirmation 'password'
end