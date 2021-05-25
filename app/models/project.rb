class Project < ApplicationRecord
    belongs_to :company
    belongs_to :user
    has_many :segments
    has_many :teams, through: :segments
    has_many :project_comments
    has_many :users, through: :project_comments

    accepts_nested_attributes_for :segments
end
