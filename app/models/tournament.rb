class Tournament < ApplicationRecord
    validates_presence_of :name, :city
    has_many :teams
    has_many :assessments
end
