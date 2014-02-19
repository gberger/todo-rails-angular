class User < ActiveRecord::Base
  has_secure_password validations: false # This is the key to the solution
  validates :password, presence: true, length: { minimum: 8 }
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }

  has_many :api_keys
  has_many :todos

  def as_json(options)
    {email: email}
  end
end
