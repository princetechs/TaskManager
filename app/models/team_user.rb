class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :role 
  has_many :task_assignments, dependent: :destroy
end
