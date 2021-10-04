class Tournament < ApplicationRecord
    validates_presence_of :name, :city, :start_date
    validates :state, length: {is: 2}, presence: true
    has_many :teams
    has_many :assessments
end
