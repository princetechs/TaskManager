class Role < ApplicationRecord
  has_many :team_users, dependent: :destroy # Ensure team_users are destroyed when the role is deleted (if needed)
  has_many :users, through: :team_users
  has_many :teams, through: :team_users
end
