Factory.define :user do |f|
  f.first_name 'John'
  f.last_name 'Doe'
  f.sequence(:email) {|n| "john.doe#{n}@example.com"}
  f.password 'password'
end