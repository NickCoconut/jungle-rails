class User < ActiveRecord::Base
  has_secure_password


  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 3 }, confirmation: true
  validates :password_confirmation, presence: true, length: { minimum: 3 }


  def self.authenticate_with_credentials(email, password)
    email = email.downcase.strip
    user = User.find_by_email(email)
    # If there is a user, authenticate it and return the user or nil. Else, return nil.
    user ? user.authenticate(password)? user : nil : nil
  end

end
