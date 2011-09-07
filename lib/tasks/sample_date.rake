namespace :db do
  desc "Fill the database with sample data"
  task :populate => :environment do
    # Reset the database
    Rake::Task['db:reset'].invoke
    
    # Create a non random user so we can log in
    User.create!(:username => "user",
                 :email => "user@example.com",
                 :password => "password",
                 :password_confirmation => "password")
    
    # Create 6 other users
    8.times do |n|
      username = Faker::Name.first_name + Faker::Name.last_name + "#{rand(9)}#{n+1}"
      email = "#{username.downcase}@example.com"
      password = "password"
      User.create!(:username => username,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
