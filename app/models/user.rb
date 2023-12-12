class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 10 }
    validates :password, presence: true
    validates :email, presence: true,uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format" }

    has_many :team_users
    has_many :teams, through: :team_users
    has_many :roles, through: :team_users
end

  