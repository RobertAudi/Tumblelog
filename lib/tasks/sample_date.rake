namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    # Reset the database
    Rake::Task['db:reset'].invoke
    
    # Create a non random user so we can log in
    User.create!(:username => "user",
                 :email => "user@example.com",
                 :password => "password",
                 :password_confirmation => "password",
                 :admin => "0")

    # Create an admin user
    User.create!(:username => "admin",
                 :email => "admin@example.com",
                 :password => "admin",
                 :password_confirmation => "admin",
                 :admin => "1")


    # Create 6 other users
    8.times do |n|
      username = Faker::Name.first_name + Faker::Name.last_name + "#{rand(9)}#{n+1}"
      email = "#{username.downcase}@example.com"
      password = "password"
      User.create!(:username => username,
                   :email => email,
                   :password => password,
                   :password_confirmation => password,
                   :admin => "0")
    end
    
    100.times do
      user = User.find_by_id(rand(6) + 1)
      title = Faker::Lorem.words(5).join(" ").capitalize
      body = Faker::Lorem.paragraph(rand(42)+2)

      user.posts.create!(:title => title,
                         :body => body,
                         :draft => 0)
    end

    # Create five draft posts
    5.times do
      user = User.find_by_id(rand(6) + 1)
      title = Faker::Lorem.words(5).join(" ").capitalize
      body = Faker::Lorem.paragraph(rand(42)+2)

      user.posts.create!(:title => title,
                         :body => body,
                         :draft => 1)
    end
    
  end
end
