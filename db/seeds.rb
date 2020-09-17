# 9.times do |n|
#   name = "name#{n}"
#   email = "task#{n}@example.com"
#   password = "password"
#   User.create!(name: name,
#                email: email,
#                password: password,
#                password_confirmation: password,
#                )
# end

# User.create!(name: "admin",
#              email: "admin22@example.com",
#              password: "password",
#              password_confirmation: "password",
#              admin: true
#              )

# (1..10).each do |n|
#   label_type = "label#{n}"
#   Label.create!(label_type: label_type,
#                )
# end
#
# (1..10).each do |n|
#   Task.create!(
#     name: "タスク#{n}",
#     content: "タスク内容#{n}",
#     user_id:  User.first.id
#   )
# end
name = Faker::Games::Pokemon.name
email = Faker::Internet.email
password = "password"
User.create!(name: name,
             email: email,
             password: password,
             password_confirmation: password,
             admin: true
             )
9.times do |n|
 name = Faker::Games::Pokemon.name
 email = Faker::Internet.email
 password = "password"
 User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password,
              )
end
