FactoryBot.define do
  factory :task do
    name { 'test_name' }
    content { 'test_content' }
    deadline { Date.today }
    status { '未着手' }
    priority { '中' }
    user
  end
end
