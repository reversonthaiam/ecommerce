class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates :role, inclusion: { in: %w[admin user] }

  def admin?
    role == "admin"
  end
end
