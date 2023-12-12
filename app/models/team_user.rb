class TeamUser < ApplicationRecord
  belongs_to :user, dependent: :destroy # Ensure user is deleted if the TeamUser is deleted (if needed)
  belongs_to :team, dependent: :destroy # Ensure team is deleted if the TeamUser is deleted (if needed)
  belongs_to :role # Consider if you want to add `dependent: :destroy` based on business logic
end
