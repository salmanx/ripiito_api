# Note:
# User model with JWT implementation will be removed eventually
# and replaced with oauth
# it's only frontend test purpose

class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, length: { minimum: 3, maximum: 100 }
  validates :password, presence: true
end
