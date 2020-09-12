class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true

  scope :name_search, -> (name){ where('name LIKE ?', "%#{name}%") }
  scope :status_search, -> (status){ where(status: "#{status}")}

  enum priority:{  low: 0, medium: 1, high: 2 }
end
