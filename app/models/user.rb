class User < ApplicationRecord
    validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    validates :password, presence: true
    has_many :assessments
    has_many :notes, through: :assessments
    has_secure_password
end
