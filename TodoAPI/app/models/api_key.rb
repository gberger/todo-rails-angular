class ApiKey < ActiveRecord::Base
  validates :user, presence: true

  belongs_to :user

  def as_json(options)
    {access_token: access_token, expires_at: expires_at}
  end

  def expired?
    Time.new < expires_at
  end

  private

  before_create :generate_access_token
  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

  before_create :generate_expiration_date
  def generate_expiration_date
    self.expires_at = 30.days.from_now
  end
end
