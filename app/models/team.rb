class Team < ApplicationRecord
    has_many :players
    belongs_to :tournament
    validates_presence_of :name
end
