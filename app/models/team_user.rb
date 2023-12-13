class TeamUser < ApplicationRecord
  belongs_to :user, dependent: :destroy 
  belongs_to :team, dependent: :destroy 
  belongs_to :role 
  has_many :task_assignment, dependent: :destroy
end
