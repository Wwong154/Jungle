class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 8, maximum: 20
  has_secure_password
end
