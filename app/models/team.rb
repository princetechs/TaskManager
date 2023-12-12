class Team < ApplicationRecord
    has_many :team_users, dependent: :destroy # Ensure team_users are destroyed when the team is deleted
    has_many :users, through: :team_users, dependent: :destroy # Ensure associated users are destroyed when the team is deleted
    has_many :roles, through: :team_users
    has_many :tasks, dependent: :destroy # Ensure tasks are destroyed when the team is deleted
    has_many :members, through: :team_users, source: :user
  end
  