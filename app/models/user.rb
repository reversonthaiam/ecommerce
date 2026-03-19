class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist
end
