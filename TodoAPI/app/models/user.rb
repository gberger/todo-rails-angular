class User < ActiveRecord::Base
  has_secure_password validations: false # This is the key to the solution
  validates :password, presence: true,  length: { minimum: 8 }, on: :create
  validates :password, allow_nil: true, length: { minimum: 8 }, on: :update
  validates :email, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }

  has_many :todos

  def as_json(options)
    pick(:email, :api_key, :api_key_expires_at)
  end

  def api_key_expired?
    Time.new > api_key_expires_at
  end

  def reset_api_key!
    generate_api_key!
    save
  end

  private

  before_create :generate_api_key!
  def generate_api_key!
    begin
      self.api_key = SecureRandom.hex
    end while self.class.exists?(api_key: api_key)
    self.api_key_expires_at = 30.days.from_now
  end

  after_find :renew_api_key!
  def renew_api_key!
    if api_key_expired?
      reset_api_key!
    end
  end

end
