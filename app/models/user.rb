class User < ApplicationRecord
  has_secure_password
  before_validation :downcase_email
  before_create :set_api_key

  validates :email, uniqueness: true,
                    presence: true,
                    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :password
  validates :password_confirmation, presence: true
  validates :api_key, uniqueness: true

  private

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def set_api_key
    self.api_key = SecureRandom.base64.tr("+/=","Qrt")
  end
end
