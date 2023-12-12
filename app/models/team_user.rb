class TeamUser < ApplicationRecord
  belongs_to :user
  belongs_to :team
  belongs_to :role
end
