class Player < ApplicationRecord
    belongs_to :team
    has_many :assessments
    validates :birthday, format: /\d{4}\-\d{2}\-\d{2}/
end
