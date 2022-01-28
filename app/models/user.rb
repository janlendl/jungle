class User < ActiveRecord::Base

  has_secure_password   # authentication method via bcrypt

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  before_save { self.email.downcase! }

  def authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
