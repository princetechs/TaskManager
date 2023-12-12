class TaskAssignment < ApplicationRecord
  belongs_to :task, dependent: :destroy # Ensure task_assignment is destroyed when the associated task is deleted (if needed)
  belongs_to :team_user, dependent: :destroy # Ensure task_assignment is destroyed when the associated team_user is deleted (if needed)
end
