class Tournament < ApplicationRecord
    validates_presence_of :name, :city
    validates :state, length: {is: 2}, presence: true
    validates :start_date, presence: true, format: /\d{4}\-\d{2}\-\d{2}/
    has_many :teams
    has_many :assessments
end
