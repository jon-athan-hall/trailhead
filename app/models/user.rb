class User < ApplicationRecord
  has_secure_password

  # Validations
  validates :name,
            presence: true,
            length: { minimum: 2 }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /@/ }
  validates :password,
            presence: true,
            length: { minimum: 8 },
            confirmation: true,
            on: :create
  validates :password_confirmation,
            presence: true,
            on: :create

  # Callbacks
  before_save :clean_up_email
  before_create :generate_confirmation_data

  private

  def clean_up_email
    self.email = self.email.delete(' ').downcase
  end

  def generate_confirmation_data
    self.confirmation_token = SecureRandom.hex(16)
    self.confirmation_sent_at = Time.now.utc
  end
end
