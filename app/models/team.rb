class Team < ApplicationRecord
    has_many :team_users, dependent: :destroy 
    has_many :tasks, dependent: :destroy 
    has_many :task_assignments, through: :tasks
#through assosiations
    has_many :users, through: :team_users, dependent: :destroy 
    has_many :members, through: :team_users, source: :user
    has_many :roles, through: :team_users
  end
  