class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }
end
