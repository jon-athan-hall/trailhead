class Role < ApplicationRecord
  # Validations
  validates :name,
            presence: true,
            uniqueness: true
end
