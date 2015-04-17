class User < ActiveRecord::Base
  has_many :authentications
  has_secure_password

  has_many :favorite_properties
  has_many :user_preferences

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_length_of :password,
                      minimum: 5,
                      maximum: 15
end
