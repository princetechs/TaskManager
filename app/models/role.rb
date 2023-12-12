class Role < ApplicationRecord
    # has_many :users
    has_many :team_users
    has_many :users, through: :team_users
    has_many :teams, through: :team_users
  end
  