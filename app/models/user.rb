
class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    before_save { self.email = email.downcase }

    validates :name, 
        presence: true, 
        length: { maximum: 50 }
    validates :email, 
        presence: true, 
        length: { maximum: 128 },
        format: { with: VALID_EMAIL_REGEX }

    validates :password,
        presence: true,
        length: { minimum: 8 }

    has_secure_password
end
