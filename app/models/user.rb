class User < ApplicationRecord
  has_secure_password
  before_validation :downcase_email

  validates :email, uniqueness: true,
                    presence: true,
                    format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates_presence_of :password

  private
  def downcase_email
    self.email = email.downcase if email.present?
  end
end
