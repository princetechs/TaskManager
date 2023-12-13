class User < ApplicationRecord
    has_secure_password
  
    validates :name, presence: true, uniqueness: true, length: { in: 3..10 }
    validates :password, presence: true, length: { minimum: 6 }, on: :create
    validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format" }
  
    has_many :team_users, dependent: :destroy 
    has_many :teams, through: :team_users, dependent: :destroy 
    has_many :roles, through: :team_users
    
  end
  