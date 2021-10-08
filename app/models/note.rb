class Note < ApplicationRecord
  belongs_to :assessment, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
