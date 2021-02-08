class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates_uniqueness_of :email, :case_sensitive => false
  validates_length_of :password, minimum: 8, maximum: 200
  has_secure_password
  def self.authenticate_with_credentials (email, password)
    @user = User.find_by_email(email.strip.downcase)
    if @user && @user.authenticate(password)
      return @user.id
    end
    nil
  end
end
