class User < ActiveRecord::Base

  has_secure_password   # authentication method via bcrypt

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }
  before_save { self.email.downcase! }
end
