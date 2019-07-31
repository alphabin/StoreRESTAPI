class Customer < ApplicationRecord
    validates :firstName, presence: true
    validates :lastName, presence: true
    validates :email, presence: true, 
        uniqueness: { case_sensitive: false }, 
        format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
        message: "only allows letters" }
end
