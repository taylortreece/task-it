class Team < ApplicationRecord
    belongs_to :company
    belongs_to :user
    has_many :positions, dependent: :destroy
    has_many :users, through: :positions
    has_many :segments, dependent: :destroy
    has_many :projects, through: :segments
end
