class Role < ApplicationRecord
  has_many :team_users, dependent: :destroy 
  has_many :users, through: :team_users
  has_many :teams, through: :team_users
  validates :name, presence: true, uniqueness: true
end
