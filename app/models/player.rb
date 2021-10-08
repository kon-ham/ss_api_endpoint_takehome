class Player < ApplicationRecord
    belongs_to :team
    has_many :assessments
    # utilized regular expression to sanitize birthday to 'XXXX-XX-XX' format, however
    # the testing of the regular expression capability has only been tested indirectly
    # via FactoryBot
    validates :birthday, format: /\d{4}\-\d{2}\-\d{2}/
end
