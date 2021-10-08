class Tournament < ApplicationRecord
    validates_presence_of :name, :city
    validates :state, length: {is: 2}, presence: true
    # similar to the regular expression utilized in Player model, the author has 
    # utilized regular expression to sanitize birthday to 'XXXX-XX-XX' format, however
    # the testing of the regular expression capability has only been tested indirectly
    # via FactoryBot
    validates :start_date, presence: true, format: /\d{4}\-\d{2}\-\d{2}/
    has_many :teams
    has_many :assessments
end
