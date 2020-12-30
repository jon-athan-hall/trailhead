class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /@/ }

  # Callbacks
  before_save :clean_up_email

  private

  def clean_up_email
    self.email = self.email.delete(' ').downcase
  end
end
