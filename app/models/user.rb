class User < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 20 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }, on: [:create]

  has_many :tasks, dependent: :destroy

  before_update :check_admin_update
  before_destroy :check_admin_destroy

  private
  def check_admin_update
    if User.where(admin: true).count == 1 && self.admin == false
      errors.add :base, '管理者がいなくなるため、このユーザーの権限は変更できません。'
      throw(:abort)
    end
  end
  def check_admin_destroy
    if User.where(admin: true).count == 1 && self.admin == true
      errors.add :base, '管理者がいなくなるため、このユーザーは削除できません。'
      throw(:abort)
    end
  end
end
