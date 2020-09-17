FactoryBot.define do
  factory :label do
    label_type { 'label1' }
  end
  factory :task_label, class: Task do
    name { 'test_label' }
    content { 'test_content' }
    deadline { Date.today }
    status { '未着手' }
    priority { '中' }
    user
  end
end
