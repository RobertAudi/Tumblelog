Factory.define :user do |user|
  user.username "admin"
  user.email "admin@example.com"
  user.password "admin"
  user.password_confirmation "admin"
end

Factory.sequence :username do |n|
  "person_#{n}"
end

Factory.sequence :email do |n|
  "person_#{n}@example.com"
end