class Label < ApplicationRecord
  has_many :connects, dependent: :destroy
  has_many :tasks, through: :connects
end
