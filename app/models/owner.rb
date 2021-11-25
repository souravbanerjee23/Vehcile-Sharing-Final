class Owner < ApplicationRecord
    has_secure_password
    validates :email,presence: true,format: {with: /\A[^@\s]+@[^@\s]+\z/}
    validates :phone,presence: true
    validates :name,presence: true
end
