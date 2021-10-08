class Note < ApplicationRecord
  # author has not yet tested dependent: :destroy relationship
  # so robustness of line 4 is not validated
  belongs_to :assessment, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
