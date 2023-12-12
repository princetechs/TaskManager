class Task < ApplicationRecord
  belongs_to :team, dependent: :destroy # Ensure task is destroyed when the associated team is deleted
  has_many :task_assignments, dependent: :destroy # Ensure task_assignments are destroyed when the task is deleted
  has_many :assigned_members, through: :task_assignments, source: :team_user
end
