class Assessment < ApplicationRecord
  belongs_to :user
  belongs_to :player
  has_many :notes
end
