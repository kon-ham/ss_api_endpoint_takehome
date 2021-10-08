class User < ApplicationRecord
    # utilized regular expression to sanitize email format to be 'xxx@xxx.com'
    # robustness of this feature has only been tested indirectly
    validates :email, uniqueness: true, presence: true, format: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    validates :password, presence: true
    has_many :assessments
    has_many :notes, through: :assessments
    has_secure_password
end
