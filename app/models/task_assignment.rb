class TaskAssignment < ApplicationRecord
  belongs_to :task
  belongs_to :team_user
  has_one :team, through: :team_user
end
