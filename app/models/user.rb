class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :name,
            presence: true,
            length: { minimum: 8 }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /@/ }
  validates :password, presence: true, length: { minimum: 8 }, confirmation: true
  validates :password_confirmation, presence: true

  # Callbacks
  before_save :clean_up_email

  private

  def clean_up_email
    self.email = email.delete(' ').downcase
  end
end
