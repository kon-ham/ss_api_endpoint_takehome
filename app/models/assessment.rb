class Assessment < ApplicationRecord
  belongs_to :user
  belongs_to :player
  belongs_to :tournament
  has_many :notes
end
