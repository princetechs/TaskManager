class TaskAssignment < ApplicationRecord
  belongs_to :task, dependent: :destroy 
  belongs_to :team_user, dependent: :destroy 
end
