class SegmentComment < ApplicationRecord
    belongs_to :user
    belongs_to :segment

    validates :content, presence: true
end
