FactoryBot.define do
  factory :user do
    name { 'test1_name' }
    email { 'test111@example.com' }
    password { 'test01' }
    password_confirmation { 'test01' }
  end
  factory :admin_user do
    name { 'admin_name' }
    email { 'admin@example.com' }
    password { 'admin1' }
    password_confirmation { 'admin1' }
    admin { true }
  end
end
