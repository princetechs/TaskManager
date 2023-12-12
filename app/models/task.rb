class Task < ApplicationRecord
    belongs_to :team
    has_many :task_assignments
    has_many :assigned_members, through: :task_assignments, source: :team_user
  end
  