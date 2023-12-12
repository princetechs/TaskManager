class Team < ApplicationRecord
    has_many :team_users
    has_many :users, through: :team_users
    has_many :roles, through: :team_users
    has_many :tasks
    has_many :members, through: :team_users, source: :user
end

  