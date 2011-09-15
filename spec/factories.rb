Factory.define :user do |user|
  user.username "admin"
  user.email "admin@example.com"
  user.password "admin"
  user.password_confirmation "admin"
  user.auth_token SecureRandom.urlsafe_base64
  user.admin "0"
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
  post.user_id 1
  post.draft 0
end

Factory.sequence :title do |n|
  "Post ##{n}"
end

Factory.sequence :body do |n|
  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore
   magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
   consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
   Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
end
