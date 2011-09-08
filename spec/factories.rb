Factory.define :user do |user|
  user.username "admin"
  user.email "admin@example.com"
  user.password "admin"
  user.password_confirmation "admin"
  user.auth_token SecureRandom.urlsafe_base64
end

Factory.sequence :username do |n|
  "person_#{n}"
end

Factory.sequence :email do |n|
  "person_#{n}@example.com"
end

Factory.define :post do |post|
  post.title "This is the title"
  post.body "Lorem ipsum dolor sit amet, consectetur adipisicing elit."
end