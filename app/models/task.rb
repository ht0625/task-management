class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  scope :name_search, -> (name){ where('name LIKE ?', "%#{name}%") }
  scope :status_search, -> (status){ where(status: "#{status}")}

  enum priority:{  "低": 0, "中": 1, "高": 2 }

  has_many :connects, dependent: :destroy
  has_many :labels, through: :connects

  belongs_to :user
end
