3.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               admin: true
               )
end
(1..5).each do |n|
  label_type = "label#{n}"
  Label.create!(label_type: label_type,
               )
end
