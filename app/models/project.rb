class Project < ApplicationRecord
    belongs_to :company
    belongs_to :user
    has_many :segments, dependent: :destroy
    has_many :teams, through: :segments
    has_many :project_comments, dependent: :destroy
    has_many :users, through: :project_comments

    validates :title, presence: true
    validates :deadline, presence: true
    validates :description, presence: true
end
