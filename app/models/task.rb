class Task < ApplicationRecord
  belongs_to :team
  has_many :task_assignments, dependent: :destroy
  has_many :assigned_members, through: :task_assignments, source: :team_user
  has_many :assigned_users, through: :assigned_members, source: :user
end
